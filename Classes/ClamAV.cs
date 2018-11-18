using System;
using System.Management.Automation;

namespace OPNsense.clamav {
	public class General {
		#region Parameters
		public bool arcblockenc { get; set; }
		public bool detectbroken { get; set; }
		public string disablecache { get; set; }
		public bool enabled { get; set; }
		public bool enabletcp { get; set; }
		public string fc_databasemirror { get; set; }
		public bool fc_enabled { get; set; }
		public bool fc_logverbose { get; set; }
		public string fc_timeout { get; set; }
		public bool followdirsym { get; set; }
		public bool followfilesym { get; set; }
		public int idletimeout { get; set; }
		public int maxdirrecursion { get; set; }
		public int maxfiles { get; set; }
		public string maxfilesize { get; set; }
		public int maxqueue { get; set; }
		public int maxrecursion { get; set; }
		public string maxscansize { get; set; }
		public int maxthreads { get; set; }
		public bool ole2blockmarcros { get; set; }
		public bool scanarchive { get; set; }
		public bool scanelf { get; set; }
		public bool scanhtml { get; set; }
		public bool scanhwp3 { get; set; }
		public bool scanmailfiles { get; set; }
		public bool scanole2 { get; set; }
		public bool scanpdf { get; set; }
		public bool scanpe { get; set; }
		public bool scanswf { get; set; }
		public bool scanxmldocs { get; set; }
		#endregion Parameters

		public General () {
			arcblockenc = true;
			detectbroken = true;
			disablecache = "0";
			enabled = true;
			enabletcp = true;
			fc_databasemirror = "database.clamav.net";
			fc_enabled = true;
			fc_logverbose = true;
			fc_timeout = "60";
			followdirsym = true;
			followfilesym = true;
			idletimeout = 30;
			maxdirrecursion = 20;
			maxfiles = 10000;
			maxfilesize = "25M";
			maxqueue = 100;
			maxrecursion = 16;
			maxscansize = "100M";
			maxthreads = 10;
			ole2blockmarcros = true;
			scanarchive = true;
			scanelf = true;
			scanhtml = true;
			scanhwp3 = true;
			scanmailfiles = true;
			scanole2 = true;
			scanpdf = true;
			scanpe = true;
			scanswf = true;
			scanxmldocs = true;
		}

		public General (
			byte Arcblockenc,
			byte Detectbroken,
			string Disablecache,
			byte Enabled,
			byte Enabletcp,
			string Fc_Databasemirror,
			byte Fc_Enabled,
			byte Fc_Logverbose,
			string Fc_Timeout,
			byte Followdirsym,
			byte Followfilesym,
			int Idletimeout,
			int Maxdirrecursion,
			int Maxfiles,
			string Maxfilesize,
			int Maxqueue,
			int Maxrecursion,
			string Maxscansize,
			int Maxthreads,
			byte Ole2blockmarcros,
			byte Scanarchive,
			byte Scanelf,
			byte Scanhtml,
			byte Scanhwp3,
			byte Scanmailfiles,
			byte Scanole2,
			byte Scanpdf,
			byte Scanpe,
			byte Scanswf,
			byte Scanxmldocs
		) {
			arcblockenc = (Arcblockenc == 0) ? false : true;
			detectbroken = (Detectbroken == 0) ? false : true;
			disablecache = Disablecache;
			enabled = (Enabled == 0) ? false : true;
			enabletcp = (Enabletcp == 0) ? false : true;
			fc_databasemirror = Fc_Databasemirror;
			fc_enabled = (Fc_Enabled == 0) ? false : true;
			fc_logverbose = (Fc_Logverbose == 0) ? false : true;
			fc_timeout = Fc_Timeout;
			followdirsym = (Followdirsym == 0) ? false : true;
			followfilesym = (Followfilesym == 0) ? false : true;
			idletimeout = Idletimeout;
			maxdirrecursion = Maxdirrecursion;
			maxfiles = Maxfiles;
			maxfilesize = Maxfilesize;
			maxqueue = Maxqueue;
			maxrecursion = Maxrecursion;
			maxscansize = Maxscansize;
			maxthreads = Maxthreads;
			ole2blockmarcros = (Ole2blockmarcros == 0) ? false : true;
			scanarchive = (Scanarchive == 0) ? false : true;
			scanelf = (Scanelf == 0) ? false : true;
			scanhtml = (Scanhtml == 0) ? false : true;
			scanhwp3 = (Scanhwp3 == 0) ? false : true;
			scanmailfiles = (Scanmailfiles == 0) ? false : true;
			scanole2 = (Scanole2 == 0) ? false : true;
			scanpdf = (Scanpdf == 0) ? false : true;
			scanpe = (Scanpe == 0) ? false : true;
			scanswf = (Scanswf == 0) ? false : true;
			scanxmldocs = (Scanxmldocs == 0) ? false : true;
		}
	}
}
