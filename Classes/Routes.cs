using System;
using System.Management.Automation;

namespace staticroutes {
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
			byte Disabled,
			PSObject Gateway,
			PSObject Network
		) {
			descr = Descr;
			disabled = (Disabled == 0) ? false : true;
			gateway = Gateway;
			network = Network;
		}
	}
}
