using System;
using System.Management.Automation;

namespace OPNsense {
	public class Nodeexporter {
		#region Parameters
		public bool cpu { get; set; }
		public bool devstat { get; set; }
		public bool enabled { get; set; }
		public bool exec { get; set; }
		public bool filesystem { get; set; }
		public bool interrupts { get; set; }
		public string listenaddress { get; set; }
		public ushort listenport { get; set; }
		public bool loadavg { get; set; }
		public bool meminfo { get; set; }
		public bool netdev { get; set; }
		public bool ntp { get; set; }
		public bool time { get; set; }
		#endregion Parameters

		public Nodeexporter () {
			cpu = true;
			devstat = true;
			enabled = true;
			exec = true;
			filesystem = true;
			interrupts = true;
			listenaddress = "0.0.0.0";
			listenport = 9100;
			loadavg = true;
			meminfo = true;
			netdev = true;
			ntp = true;
			time = true;
		}

		public Nodeexporter (
			byte Cpu,
			byte Devstat,
			byte Enabled,
			byte Exec,
			byte Filesystem,
			byte Interrupts,
			string Listenaddress,
			ushort Listenport,
			byte Loadavg,
			byte Meminfo,
			byte Netdev,
			byte Ntp,
			byte Time
		) {
			cpu = (Cpu == 0) ? false : true;
			devstat = (Devstat == 0) ? false : true;
			enabled = (Enabled == 0) ? false : true;
			exec = (Exec == 0) ? false : true;
			filesystem = (Filesystem == 0) ? false : true;
			interrupts = (Interrupts == 0) ? false : true;
			listenaddress = Listenaddress;
			listenport = Listenport;
			loadavg = (Loadavg == 0) ? false : true;
			meminfo = (Meminfo == 0) ? false : true;
			netdev = (Netdev == 0) ? false : true;
			ntp = (Ntp == 0) ? false : true;
			time = (Time == 0) ? false : true;
		}
	}
}
