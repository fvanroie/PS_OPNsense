namespace OPNsense.IDS {
	public class Rule {
		#region Paramaters
		public System.Management.Automation.PSObject action { get; set; }
		public bool enabled { get; set; }
		public int sid { get; set; }
		#endregion Paramaters

		#region Constructors
		public Rule() {
			action = null;
			enabled = false;
			sid = 0;
		}

		public Rule(
			System.Management.Automation.PSObject Action,
			bool Enabled,
			int Sid
		) {
			action = Action;
			enabled = Enabled;
			sid = Sid;
		}
		#endregion Constructors
	}
	public class UserRule {
		#region Paramaters
		public System.Management.Automation.PSObject action { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public string fingerprint { get; set; }
		public System.Management.Automation.PSObject geoip { get; set; }
		public System.Management.Automation.PSObject geoip_direction { get; set; }
		#endregion Paramaters

		#region Constructors
		public UserRule() {
			action = null;
			description = null;
			enabled = false;
			fingerprint = null;
			geoip = null;
			geoip_direction = null;
		}

		public UserRule(
			System.Management.Automation.PSObject Action,
			string Description,
			bool Enabled,
			string Fingerprint,
			System.Management.Automation.PSObject Geoip,
			System.Management.Automation.PSObject Geoip_Direction
		) {
			action = Action;
			description = Description;
			enabled = Enabled;
			fingerprint = Fingerprint;
			geoip = Geoip;
			geoip_direction = Geoip_Direction;
		}
		#endregion Constructors
	}
}
