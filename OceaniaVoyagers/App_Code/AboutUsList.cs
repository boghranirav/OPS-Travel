using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OceaniaVoyagers.App_Code
{
    public class AboutUsList
    {
        public AboutUsList() { }
        public AboutUsList(string phoneHead, string address1, string address2, string address3, string phoneFoot, 
            string descriptionFoot, string linkFB,
            string linkInsta, string linkYoutube, string linkGoogle, string linkTwitter,string emailId)
        {
            this.phoneHead = phoneHead;
            this.phoneFoot = phoneFoot;
            this.address1 = address1;
            this.address2 = address2;
            this.address3 = address3;
            this.emailId = emailId;
            this.descriptionFoot = descriptionFoot;
            this.linkFB = linkFB;
            this.linkInsta = linkInsta;
            this.linkYoutube = linkYoutube;
            this.linkGoogle = linkGoogle;
            this.linkTwitter = linkTwitter;
        }
        public string phoneHead { get; set; } = string.Empty;
        public string address1 { get; set; } = string.Empty;
        public string address2{ get; set; } = string.Empty;
        public string address3 { get; set; } = string.Empty;
        public string emailId { get; set; } = string.Empty;
        public string phoneFoot { get; set; } = string.Empty;
        public string descriptionFoot { get; set; } = string.Empty;
        public string linkFB { get; set; } = string.Empty;
        public string linkInsta { get; set; } = string.Empty;
        public string linkYoutube { get; set; } = string.Empty;
        public string linkGoogle { get; set; } = string.Empty;
        public string linkTwitter { get; set; } = string.Empty;
    }
}