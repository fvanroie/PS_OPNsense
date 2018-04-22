namespace OPNsense.Routes {
	public class Route {
		#region Paramaters
		public string descr { get; set; }
		public bool disabled { get; set; }
		public System.Management.Automation.PSObject gateway { get; set; }
		public System.Management.Automation.PSObject network { get; set; }
		#endregion Paramaters

		#region Constructors
		public Route() {
			descr = null;
			disabled = false;
			gateway = null;
			network = null;
		}

		public Route(
			string Descr,
			bool Disabled,
			System.Management.Automation.PSObject Gateway,
			System.Management.Automation.PSObject Network
		) {
			descr = Descr;
			disabled = Disabled;
			gateway = Gateway;
			network = Network;
		}
		#endregion Constructors
	}
}
