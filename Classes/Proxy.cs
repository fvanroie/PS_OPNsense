using System;
using System.Management.Automation;

namespace OPNsense.Proxy {
	public class RemoteBlacklist {
		#region Parameters
		public string description { get; set; }
		public bool enabled { get; set; }
		public string filename { get; set; }
		public PSObject filter { get; set; }
		public string password { get; set; }
		public bool sslNoVerify { get; set; }
		public string url { get; set; }
		public string username { get; set; }
		#endregion Parameters

		public RemoteBlacklist () {
			description = null;
			enabled = true;
			filename = null;
			filter = null;
			password = null;
			sslNoVerify = true;
			url = null;
			username = null;
		}

		public RemoteBlacklist (
			string Description,
			byte Enabled,
			string Filename,
			PSObject Filter,
			string Password,
			byte SslNoVerify,
			string Url,
			string Username
		) {
			description = Description;
			enabled = (Enabled == 0) ? false : true;
			filename = Filename;
			filter = Filter;
			password = Password;
			sslNoVerify = (SslNoVerify == 0) ? false : true;
			url = Url;
			username = Username;
		}
	}
}
