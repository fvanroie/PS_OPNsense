using System;
using System.Management.Automation;

namespace OPNsense.cicap {
	public class General {
		#region Parameters
		public bool enabled { get; set; }
		public bool enable_accesslog { get; set; }
		public int keepalivetimeout { get; set; }
		public PSObject listenaddress { get; set; }
		public bool localSquid { get; set; }
		public int maxkeepaliverequests { get; set; }
		public int maxrequestsperchild { get; set; }
		public int maxservers { get; set; }
		public int maxsparethreads { get; set; }
		public int minsparethreads { get; set; }
		public string serveradmin { get; set; }
		public string servername { get; set; }
		public int startservers { get; set; }
		public int threadsperchild { get; set; }
		public int timeout { get; set; }
		#endregion Parameters

		public General () {
			enabled = true;
			enable_accesslog = true;
			keepalivetimeout = 600;
			listenaddress = null;
			localSquid = true;
			maxkeepaliverequests = 100;
			maxrequestsperchild = 0;
			maxservers = 10;
			maxsparethreads = 20;
			minsparethreads = 10;
			serveradmin = null;
			servername = null;
			startservers = 3;
			threadsperchild = 10;
			timeout = 300;
		}

		public General (
			byte Enabled,
			byte Enable_Accesslog,
			int Keepalivetimeout,
			PSObject Listenaddress,
			byte LocalSquid,
			int Maxkeepaliverequests,
			int Maxrequestsperchild,
			int Maxservers,
			int Maxsparethreads,
			int Minsparethreads,
			string Serveradmin,
			string Servername,
			int Startservers,
			int Threadsperchild,
			int Timeout
		) {
			enabled = (Enabled == 0) ? false : true;
			enable_accesslog = (Enable_Accesslog == 0) ? false : true;
			keepalivetimeout = Keepalivetimeout;
			listenaddress = Listenaddress;
			localSquid = (LocalSquid == 0) ? false : true;
			maxkeepaliverequests = Maxkeepaliverequests;
			maxrequestsperchild = Maxrequestsperchild;
			maxservers = Maxservers;
			maxsparethreads = Maxsparethreads;
			minsparethreads = Minsparethreads;
			serveradmin = Serveradmin;
			servername = Servername;
			startservers = Startservers;
			threadsperchild = Threadsperchild;
			timeout = Timeout;
		}
	}
}
namespace OPNsense.cicap {
	public class Antivirus {
		#region Parameters
		public bool allow204responses { get; set; }
		public bool enable_clamav { get; set; }
		public string maxobjectsize { get; set; }
		public bool passonerror { get; set; }
		public PSObject scanfiletypes { get; set; }
		public int sendpercentdata { get; set; }
		public string startsendpercentdataafter { get; set; }
		#endregion Parameters

		public Antivirus () {
			allow204responses = true;
			enable_clamav = true;
			maxobjectsize = "5M";
			passonerror = true;
			scanfiletypes = null;
			sendpercentdata = 5;
			startsendpercentdataafter = "2M";
		}

		public Antivirus (
			byte Allow204responses,
			byte Enable_Clamav,
			string Maxobjectsize,
			byte Passonerror,
			PSObject Scanfiletypes,
			int Sendpercentdata,
			string Startsendpercentdataafter
		) {
			allow204responses = (Allow204responses == 0) ? false : true;
			enable_clamav = (Enable_Clamav == 0) ? false : true;
			maxobjectsize = Maxobjectsize;
			passonerror = (Passonerror == 0) ? false : true;
			scanfiletypes = Scanfiletypes;
			sendpercentdata = Sendpercentdata;
			startsendpercentdataafter = Startsendpercentdataafter;
		}
	}
}
