using System;
using System.Management.Automation;

namespace OPNsense.IDS.files {
	public class File {
		#region Parameters
		public bool enabled { get; set; }
		public string filename { get; set; }
		public PSObject filter { get; set; }
		#endregion Parameters

		public File () {
			enabled = true;
			filename = null;
			filter = null;
		}

		public File (
			byte Enabled,
			string Filename,
			PSObject Filter
		) {
			enabled = (Enabled == 0) ? false : true;
			filename = Filename;
			filter = Filter;
		}
	}
}
namespace OPNsense.IDS.fileTags {
	public class Tag {
		#region Parameters
		public string property { get; set; }
		public string value { get; set; }
		#endregion Parameters

		public Tag () {
			property = null;
			value = null;
		}

		public Tag (
			string Property,
			string Value
		) {
			property = Property;
			value = Value;
		}
	}
}
namespace OPNsense.IDS.rules {
	public class Rule {
		#region Parameters
		public PSObject action { get; set; }
		public bool enabled { get; set; }
		public int sid { get; set; }
		#endregion Parameters

		public Rule () {
			action = null;
			enabled = true;
			sid = 0;
		}

		public Rule (
			PSObject Action,
			byte Enabled,
			int Sid
		) {
			action = Action;
			enabled = (Enabled == 0) ? false : true;
			sid = Sid;
		}
	}
}
namespace OPNsense.IDS.userDefinedRules {
	public class Rule {
		#region Parameters
		public PSObject action { get; set; }
		public string description { get; set; }
		public PSObject destination { get; set; }
		public bool enabled { get; set; }
		public string fingerprint { get; set; }
		public PSObject source { get; set; }
		#endregion Parameters

		public Rule () {
			action = null;
			description = null;
			destination = null;
			enabled = true;
			fingerprint = null;
			source = null;
		}

		public Rule (
			PSObject Action,
			string Description,
			PSObject Destination,
			byte Enabled,
			string Fingerprint,
			PSObject Source
		) {
			action = Action;
			description = Description;
			destination = Destination;
			enabled = (Enabled == 0) ? false : true;
			fingerprint = Fingerprint;
			source = Source;
		}
	}
}
namespace OPNsense.IDS {
	public class General {
		#region Parameters
		public PSObject AlertLogrotate { get; set; }
		public ushort AlertSaveLogs { get; set; }
		public ushort defaultPacketSize { get; set; }
		public bool enabled { get; set; }
		public PSObject homenet { get; set; }
		public PSObject interfaces { get; set; }
		public bool ips { get; set; }
		public bool LogPayload { get; set; }
		public PSObject MPMAlgo { get; set; }
		public bool promisc { get; set; }
		public bool syslog { get; set; }
		public PSObject UpdateCron { get; set; }
		#endregion Parameters

		public General () {
			AlertLogrotate = null;
			AlertSaveLogs = 4;
			defaultPacketSize = 0;
			enabled = true;
			homenet = null;
			interfaces = null;
			ips = true;
			LogPayload = true;
			MPMAlgo = null;
			promisc = true;
			syslog = true;
			UpdateCron = null;
		}

		public General (
			PSObject alertlogrotate,
			ushort alertsavelogs,
			ushort DefaultPacketSize,
			byte Enabled,
			PSObject Homenet,
			PSObject Interfaces,
			byte Ips,
			byte logpayload,
			PSObject mpmalgo,
			byte Promisc,
			byte Syslog,
			PSObject updatecron
		) {
			AlertLogrotate = alertlogrotate;
			AlertSaveLogs = alertsavelogs;
			defaultPacketSize = DefaultPacketSize;
			enabled = (Enabled == 0) ? false : true;
			homenet = Homenet;
			interfaces = Interfaces;
			ips = (Ips == 0) ? false : true;
			LogPayload = (logpayload == 0) ? false : true;
			MPMAlgo = mpmalgo;
			promisc = (Promisc == 0) ? false : true;
			syslog = (Syslog == 0) ? false : true;
			UpdateCron = updatecron;
		}
	}
}
