using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OceaniaVoyagers.App_Code
{
    public class PackageActivityEnquiry
    {
        public PackageActivityEnquiry() { }
        public PackageActivityEnquiry(int iActivityId)
        {
            this.iActivityId = iActivityId;
        }
        public int iActivityId { get; set; } = 0;
    }
}