namespace OPNsense.Proxy {
	public class RemoteBlacklist {
		#region Paramaters
		public string description { get; set; }
		public bool enabled { get; set; }
		public string filename { get; set; }
		public System.Management.Automation.PSObject filter { get; set; }
		public string password { get; set; }
		public bool sslNoVerify { get; set; }
		public string url { get; set; }
		public string username { get; set; }
		#endregion Paramaters

		#region Constructors
		public RemoteBlacklist() {
			description = null;
			enabled = false;
			filename = null;
			filter = null;
			password = null;
			sslNoVerify = false;
			url = null;
			username = null;
		}

		public RemoteBlacklist(
			string Description,
			bool Enabled,
			string Filename,
			System.Management.Automation.PSObject Filter,
			string Password,
			bool SslNoVerify,
			string Url,
			string Username
		) {
			description = Description;
			enabled = Enabled;
			filename = Filename;
			filter = Filter;
			password = Password;
			sslNoVerify = SslNoVerify;
			url = Url;
			username = Username;
		}
		#endregion Constructors
	}
}
