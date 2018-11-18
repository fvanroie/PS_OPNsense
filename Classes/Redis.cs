using System;
using System.Management.Automation;

namespace OPNsense.redis {
	public class General {
		#region Parameters
		public uint databases { get; set; }
		public bool enabled { get; set; }
		public PSObject listen { get; set; }
		public PSObject log_level { get; set; }
		public uint port { get; set; }
		public bool protected_mode { get; set; }
		public bool syslog_enabled { get; set; }
		public PSObject syslog_facility { get; set; }
		#endregion Parameters

		public General () {
			databases = 16;
			enabled = true;
			listen = null;
			log_level = null;
			port = 6379;
			protected_mode = true;
			syslog_enabled = true;
			syslog_facility = null;
		}

		public General (
			uint Databases,
			byte Enabled,
			PSObject Listen,
			PSObject Log_Level,
			uint Port,
			byte Protected_Mode,
			byte Syslog_Enabled,
			PSObject Syslog_Facility
		) {
			databases = Databases;
			enabled = (Enabled == 0) ? false : true;
			listen = Listen;
			log_level = Log_Level;
			port = Port;
			protected_mode = (Protected_Mode == 0) ? false : true;
			syslog_enabled = (Syslog_Enabled == 0) ? false : true;
			syslog_facility = Syslog_Facility;
		}
	}
}
namespace OPNsense.redis {
	public class Limits {
		#region Parameters
		public uint maxclients { get; set; }
		public uint maxmemory { get; set; }
		public PSObject maxmemory_policy { get; set; }
		public uint maxmemory_samples { get; set; }
		#endregion Parameters

		public Limits () {
			maxclients = 10000;
			maxmemory = 0;
			maxmemory_policy = null;
			maxmemory_samples = 5;
		}

		public Limits (
			uint Maxclients,
			uint Maxmemory,
			PSObject Maxmemory_Policy,
			uint Maxmemory_Samples
		) {
			maxclients = Maxclients;
			maxmemory = Maxmemory;
			maxmemory_policy = Maxmemory_Policy;
			maxmemory_samples = Maxmemory_Samples;
		}
	}
}
namespace OPNsense.redis {
	public class Security {
		#region Parameters
		public Object disable_commands { get; set; }
		public string password { get; set; }
		#endregion Parameters

		public Security () {
			disable_commands = null;
			password = null;
		}

		public Security (
			Object Disable_Commands,
			string Password
		) {
			disable_commands = Disable_Commands;
			password = Password;
		}
	}
}
namespace OPNsense.redis {
	public class Slowlog {
		#region Parameters
		public uint max_len { get; set; }
		public uint slower_than { get; set; }
		#endregion Parameters

		public Slowlog () {
			max_len = 128;
			slower_than = 10000;
		}

		public Slowlog (
			uint Max_Len,
			uint Slower_Than
		) {
			max_len = Max_Len;
			slower_than = Slower_Than;
		}
	}
}
