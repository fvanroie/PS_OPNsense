using System;
using System.Management.Automation;

namespace OPNsense.ftpproxies {
	public class Ftpproxy {
		#region Parameters
		public uint debuglevel { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public uint idletimeout { get; set; }
		public string listenaddress { get; set; }
		public uint listenport { get; set; }
		public bool logconnections { get; set; }
		public uint maxsessions { get; set; }
		public string reverseaddress { get; set; }
		public uint reverseport { get; set; }
		public bool rewritesourceport { get; set; }
		public string sourceaddress { get; set; }
		#endregion Parameters

		public Ftpproxy () {
			debuglevel = 5;
			description = null;
			enabled = true;
			idletimeout = 86400;
			listenaddress = "127.0.0.1";
			listenport = 8021;
			logconnections = true;
			maxsessions = 100;
			reverseaddress = null;
			reverseport = 21;
			rewritesourceport = true;
			sourceaddress = null;
		}

		public Ftpproxy (
			uint Debuglevel,
			string Description,
			byte Enabled,
			uint Idletimeout,
			string Listenaddress,
			uint Listenport,
			byte Logconnections,
			uint Maxsessions,
			string Reverseaddress,
			uint Reverseport,
			byte Rewritesourceport,
			string Sourceaddress
		) {
			debuglevel = Debuglevel;
			description = Description;
			enabled = (Enabled == 0) ? false : true;
			idletimeout = Idletimeout;
			listenaddress = Listenaddress;
			listenport = Listenport;
			logconnections = (Logconnections == 0) ? false : true;
			maxsessions = Maxsessions;
			reverseaddress = Reverseaddress;
			reverseport = Reverseport;
			rewritesourceport = (Rewritesourceport == 0) ? false : true;
			sourceaddress = Sourceaddress;
		}
	}
}
