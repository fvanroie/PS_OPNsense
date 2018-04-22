namespace OPNsense.Postfix {
	public class Domain {
		#region Paramaters
		public string destination { get; set; }
		public string domainname { get; set; }
		public bool enabled { get; set; }
		#endregion Paramaters

		#region Constructors
		public Domain() {
			destination = null;
			domainname = null;
			enabled = false;
		}

		public Domain(
			string Destination,
			string Domainname,
			bool Enabled
		) {
			destination = Destination;
			domainname = Domainname;
			enabled = Enabled;
		}
		#endregion Constructors
	}
	public class Recipient {
		#region Paramaters
		public System.Management.Automation.PSObject action { get; set; }
		public string address { get; set; }
		public bool enabled { get; set; }
		#endregion Paramaters

		#region Constructors
		public Recipient() {
			action = null;
			address = null;
			enabled = false;
		}

		public Recipient(
			System.Management.Automation.PSObject Action,
			string Address,
			bool Enabled
		) {
			action = Action;
			address = Address;
			enabled = Enabled;
		}
		#endregion Constructors
	}
	public class Sender {
		#region Paramaters
		public System.Management.Automation.PSObject action { get; set; }
		public string address { get; set; }
		public bool enabled { get; set; }
		#endregion Paramaters

		#region Constructors
		public Sender() {
			action = null;
			address = null;
			enabled = false;
		}

		public Sender(
			System.Management.Automation.PSObject Action,
			string Address,
			bool Enabled
		) {
			action = Action;
			address = Address;
			enabled = Enabled;
		}
		#endregion Constructors
	}
}
