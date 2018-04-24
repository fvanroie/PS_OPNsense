using System;
using System.Management.Automation;

namespace OPNsense.Routes {
	public class Route {
		#region Parameters
		public string descr { get; set; }
		public bool disabled { get; set; }
		public PSObject gateway { get; set; }
		public PSObject network { get; set; }
		#endregion Parameters

		public Route () {
			descr = null;
			disabled = true;
			gateway = null;
			network = null;
		}

		public Route (
			string Descr,
			bool Disabled,
			PSObject Gateway,
			PSObject Network
		) {
			descr = Descr;
			disabled = Disabled;
			gateway = Gateway;
			network = Network;
		}
	}
}
