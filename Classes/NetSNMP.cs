using System;
using System.Management.Automation;

namespace OPNsense.netsnmp.user.users {
	public class User {
		#region Parameters
		public bool enabled { get; set; }
		public string enckey { get; set; }
		public string password { get; set; }
		public bool readwrite { get; set; }
		public string username { get; set; }
		#endregion Parameters

		public User () {
			enabled = true;
			enckey = null;
			password = null;
			readwrite = true;
			username = null;
		}

		public User (
			byte Enabled,
			string Enckey,
			string Password,
			byte Readwrite,
			string Username
		) {
			enabled = (Enabled == 0) ? false : true;
			enckey = Enckey;
			password = Password;
			readwrite = (Readwrite == 0) ? false : true;
			username = Username;
		}
	}
}
namespace OPNsense.netsnmp {
	public class General {
		#region Parameters
		public string community { get; set; }
		public bool enabled { get; set; }
		public PSObject listen { get; set; }
		public string syscontact { get; set; }
		public string syslocation { get; set; }
		#endregion Parameters

		public General () {
			community = null;
			enabled = true;
			listen = null;
			syscontact = null;
			syslocation = null;
		}

		public General (
			string Community,
			byte Enabled,
			PSObject Listen,
			string Syscontact,
			string Syslocation
		) {
			community = Community;
			enabled = (Enabled == 0) ? false : true;
			listen = Listen;
			syscontact = Syscontact;
			syslocation = Syslocation;
		}
	}
}
