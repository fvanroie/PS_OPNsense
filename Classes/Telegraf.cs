using System;
using System.Management.Automation;

namespace OPNsense.telegraf.key.keys {
	public class Key {
		#region Parameters
		public bool enabled { get; set; }
		public string name { get; set; }
		public string value { get; set; }
		#endregion Parameters

		public Key () {
			enabled = true;
			name = null;
			value = null;
		}

		public Key (
			byte Enabled,
			string Name,
			string Value
		) {
			enabled = (Enabled == 0) ? false : true;
			name = Name;
			value = Value;
		}
	}
}
