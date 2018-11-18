using System;
using System.Management.Automation;

namespace OPNsense.captiveportal.templates {
	public class Template {
		#region Parameters
		public string content { get; set; }
		public string fileid { get; set; }
		public string name { get; set; }
		#endregion Parameters

		public Template () {
			content = null;
			fileid = null;
			name = null;
		}

		public Template (
			string Content,
			string Fileid,
			string Name
		) {
			content = Content;
			fileid = Fileid;
			name = Name;
		}
	}
}
namespace OPNsense.captiveportal.zones {
	public class Zone {
		#region Parameters
		public Object allowedAddresses { get; set; }
		public Object allowedMACAddresses { get; set; }
		public PSObject authEnforceGroup { get; set; }
		public PSObject authservers { get; set; }
		public PSObject certificate { get; set; }
		public bool concurrentlogins { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public ushort hardtimeout { get; set; }
		public ushort idletimeout { get; set; }
		public PSObject interfaces { get; set; }
		public string servername { get; set; }
		public PSObject template { get; set; }
		public bool transparentHTTPProxy { get; set; }
		public bool transparentHTTPSProxy { get; set; }
		public int zoneid { get; set; }
		#endregion Parameters

		public Zone () {
			allowedAddresses = null;
			allowedMACAddresses = null;
			authEnforceGroup = null;
			authservers = null;
			certificate = null;
			concurrentlogins = true;
			description = null;
			enabled = true;
			hardtimeout = 0;
			idletimeout = 0;
			interfaces = null;
			servername = null;
			template = null;
			transparentHTTPProxy = true;
			transparentHTTPSProxy = true;
			zoneid = 0;
		}

		public Zone (
			Object AllowedAddresses,
			Object AllowedMACAddresses,
			PSObject AuthEnforceGroup,
			PSObject Authservers,
			PSObject Certificate,
			byte Concurrentlogins,
			string Description,
			byte Enabled,
			ushort Hardtimeout,
			ushort Idletimeout,
			PSObject Interfaces,
			string Servername,
			PSObject Template,
			byte TransparentHTTPProxy,
			byte TransparentHTTPSProxy,
			int Zoneid
		) {
			allowedAddresses = AllowedAddresses;
			allowedMACAddresses = AllowedMACAddresses;
			authEnforceGroup = AuthEnforceGroup;
			authservers = Authservers;
			certificate = Certificate;
			concurrentlogins = (Concurrentlogins == 0) ? false : true;
			description = Description;
			enabled = (Enabled == 0) ? false : true;
			hardtimeout = Hardtimeout;
			idletimeout = Idletimeout;
			interfaces = Interfaces;
			servername = Servername;
			template = Template;
			transparentHTTPProxy = (TransparentHTTPProxy == 0) ? false : true;
			transparentHTTPSProxy = (TransparentHTTPSProxy == 0) ? false : true;
			zoneid = Zoneid;
		}
	}
}
