using System;
using System.Management.Automation;

namespace OPNsense.quagga {
	public class Rip {
		#region Parameters
		public bool enabled { get; set; }
		public Object networks { get; set; }
		public PSObject passiveinterfaces { get; set; }
		public PSObject redistribute { get; set; }
		public byte version { get; set; }
		#endregion Parameters

		public Rip () {
			enabled = true;
			networks = null;
			passiveinterfaces = null;
			redistribute = null;
			version = 2;
		}

		public Rip (
			byte Enabled,
			Object Networks,
			PSObject Passiveinterfaces,
			PSObject Redistribute,
			byte Version
		) {
			enabled = (Enabled == 0) ? false : true;
			networks = Networks;
			passiveinterfaces = Passiveinterfaces;
			redistribute = Redistribute;
			version = Version;
		}
	}
}
