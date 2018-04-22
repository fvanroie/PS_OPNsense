namespace OPNsense.CaptivePortal {
	public class Template {
		#region Paramaters
		public string content { get; set; }
		public string fileid { get; set; }
		public string name { get; set; }
		#endregion Paramaters

		#region Constructors
		public Template() {
			content = null;
			fileid = null;
			name = null;
		}

		public Template(
			string Content,
			string Fileid,
			string Name
		) {
			content = Content;
			fileid = Fileid;
			name = Name;
		}
		#endregion Constructors
	}
	public class Zone {
		#region Paramaters
		public System.Object[] allowedAddresses { get; set; }
		public System.Object[] allowedMACAddresses { get; set; }
		public System.Management.Automation.PSObject authEnforceGroup { get; set; }
		public System.Management.Automation.PSObject authservers { get; set; }
		public System.Management.Automation.PSObject certificate { get; set; }
		public bool concurrentlogins { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public int hardtimeout { get; set; }
		public int idletimeout { get; set; }
		public System.Management.Automation.PSObject interfaces { get; set; }
		public string servername { get; set; }
		public System.Management.Automation.PSObject template { get; set; }
		public bool transparentHTTPProxy { get; set; }
		public bool transparentHTTPSProxy { get; set; }
		public int zoneid { get; set; }
		#endregion Paramaters

		#region Constructors
		public Zone() {
			allowedAddresses = null;
			allowedMACAddresses = null;
			authEnforceGroup = null;
			authservers = null;
			certificate = null;
			concurrentlogins = false;
			description = null;
			enabled = false;
			hardtimeout = 0;
			idletimeout = 0;
			interfaces = null;
			servername = null;
			template = null;
			transparentHTTPProxy = false;
			transparentHTTPSProxy = false;
			zoneid = 0;
		}

		public Zone(
			System.Object[] AllowedAddresses,
			System.Object[] AllowedMACAddresses,
			System.Management.Automation.PSObject AuthEnforceGroup,
			System.Management.Automation.PSObject Authservers,
			System.Management.Automation.PSObject Certificate,
			bool Concurrentlogins,
			string Description,
			bool Enabled,
			int Hardtimeout,
			int Idletimeout,
			System.Management.Automation.PSObject Interfaces,
			string Servername,
			System.Management.Automation.PSObject Template,
			bool TransparentHTTPProxy,
			bool TransparentHTTPSProxy,
			int Zoneid
		) {
			allowedAddresses = AllowedAddresses;
			allowedMACAddresses = AllowedMACAddresses;
			authEnforceGroup = AuthEnforceGroup;
			authservers = Authservers;
			certificate = Certificate;
			concurrentlogins = Concurrentlogins;
			description = Description;
			enabled = Enabled;
			hardtimeout = Hardtimeout;
			idletimeout = Idletimeout;
			interfaces = Interfaces;
			servername = Servername;
			template = Template;
			transparentHTTPProxy = TransparentHTTPProxy;
			transparentHTTPSProxy = TransparentHTTPSProxy;
			zoneid = Zoneid;
		}
		#endregion Constructors
	}
}
