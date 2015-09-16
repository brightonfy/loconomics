﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LcRest
{
    /// <summary>
    /// TODO Complete methods
    /// TODO Reimplement SQLs, db naming, remove LcData.*providerPackage* methods
    /// </summary>
    public class ServiceProfessionalService
    {
        #region Fields
        public int serviceProfessionalServiceID;
        public int pricingTypeID;
        public int serviceProfessionalUserID;
        public int jobTitleID;
        public int languageID;
        public int countryID;
        public string name;
        public string description;
        public decimal? price;
        public int serviceDurationMinutes = 0;
        public bool firstTimeClientsOnly = false;
        public int numberOfSessions = 1;
        public decimal? priceRate;
        public string priceRateUnit = "hour";
        public bool isPhone = false;
        public DateTime createdDate;
        public DateTime updatedDate;

        /// <summary>
        /// List of service attributes IDs that are part of the service detail
        /// </summary>
        public List<int> serviceAttributes;
        #endregion

        #region Instances
        public ServiceProfessionalService() { }
        public static ServiceProfessionalService FromDB(dynamic record, IEnumerable<dynamic> attributes = null)
        {
            if (record == null) return null;

            return new ServiceProfessionalService
            {
                serviceProfessionalServiceID = record.ProviderPackageID,
                pricingTypeID = record.PricingTypeID,
                serviceProfessionalUserID = record.ProviderUserID,
                jobTitleID = record.PositionID,
                name = record.Name,
                description = record.Description,
                price = record.Price,
                serviceDurationMinutes = record.ServiceDuration,
                firstTimeClientsOnly = record.FirstTimeClientsOnly,
                numberOfSessions = record.NumberOfSessions,
                priceRate = record.PriceRate,
                priceRateUnit = record.PriceRateUnit,
                isPhone = record.IsPhone,
                createdDate = record.CreatedDate,
                updatedDate = record.UpdatedDate,

                // Array of IDs of serviceAttributes
                serviceAttributes = (attributes == null ? null : attributes.Select(att =>
                {
                    return (int)att.ServiceAttributeID;
                }).ToList<int>())
            };
        }
        #endregion

        #region Fetch
        public static ServiceProfessionalService Get(int serviceProfessionalServiceID, int? serviceProfessionalUserID, int? jobTitleID = null)
        {
            var service = FromDB(LcData.GetProviderPackage(serviceProfessionalServiceID));
            if (service == null ||
                serviceProfessionalUserID.HasValue && service.serviceProfessionalUserID != serviceProfessionalUserID.Value ||
                jobTitleID.HasValue && service.jobTitleID != jobTitleID.Value)
            {
                // Null even if exists but does not matches the required user and jobTitle
                return null;
            }
            return service;
        }

        public void FillAttributes()
        {
            IEnumerable<dynamic> attributes = LcData.GetProviderPackageServiceAttributes(serviceProfessionalServiceID);
            // Array of IDs of serviceAttributes
            serviceAttributes = (attributes == null ? null : attributes.Select(att =>
            {
                return (int)att.ServiceAttributeID;
            }).ToList<int>());
        }

        public static IEnumerable<ServiceProfessionalService> GetList(int serviceProfessionalUserID, int jobTitleID = -1)
        {
            var packages = LcData.GetPricingPackagesByProviderPosition(serviceProfessionalUserID, jobTitleID);

            return ((IEnumerable<dynamic>)packages.Packages).Select<dynamic, ServiceProfessionalService>(pak =>
            {
                var pakID = (int)pak.ProviderPackageID;
                var hasAtts = packages.PackagesDetailsByPackage.ContainsKey(pakID);
                return FromDB(pak, hasAtts ? packages.PackagesDetailsByPackage[(int)pak.ProviderPackageID] : null);
            }).ToList();
        }

        /// <summary>
        /// Retrieve a list of services given a list of serviceIDs, all must match the given userID and belong to the same jobTitle.
        /// Used usually to prepare a PricingSummaryDetail listing, computing pricing for a booking.
        /// </summary>
        /// <param name="serviceProfessionalUserID"></param>
        /// <param name="serviceIds"></param>
        /// <returns></returns>
        public static IEnumerable<ServiceProfessionalService> GetListByIds(int serviceProfessionalUserID, IEnumerable<int> serviceIds)
        {
            int jobTitleID = 0;
            int langID = 0;
            int countryID = 0;

            using (var db = new LcDatabase())
            {
                foreach (var serviceID in serviceIds)
                {
                    var service = Get(serviceID, serviceProfessionalUserID);

                    if (service == null)
                        throw new ConstraintException("Impossible to retrieve information for the ServiceID: " + serviceID);

                    // Get and double check position
                    if (jobTitleID == 0)
                    {
                        jobTitleID = service.jobTitleID;
                        langID = service.languageID;
                        countryID = service.countryID;
                    }
                    else if (jobTitleID != service.jobTitleID ||
                        langID != service.languageID ||
                        countryID != service.countryID)
                    {
                        // All services must be part of the same position
                        throw new ConstraintException("All choosen services must belong to the same Job Title");
                    }

                    yield return service;
                }
            }
        }
        #endregion
    }
}