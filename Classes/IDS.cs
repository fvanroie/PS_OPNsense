using System;
using System.Management.Automation;

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
		public PSObject geoip { get; set; }
		public PSObject geoip_direction { get; set; }
		public PSObject source { get; set; }
		#endregion Parameters

		public Rule () {
			action = null;
			description = null;
			destination = null;
			enabled = true;
			fingerprint = null;
			geoip = null;
			geoip_direction = null;
			source = null;
		}

		public Rule (
			PSObject Action,
			string Description,
			PSObject Destination,
			byte Enabled,
			string Fingerprint,
			PSObject Geoip,
			PSObject Geoip_Direction,
			PSObject Source
		) {
			action = Action;
			description = Description;
			destination = Destination;
			enabled = (Enabled == 0) ? false : true;
			fingerprint = Fingerprint;
			geoip = Geoip;
			geoip_direction = Geoip_Direction;
			source = Source;
		}
	}
}
