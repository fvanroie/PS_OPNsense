using System;
using System.Management.Automation;

namespace OPNsense.zabbixproxy {
	public class General {
		#region Parameters
		public string cachesize { get; set; }
		public bool enabled { get; set; }
		public bool encryption { get; set; }
		public string encryptionidentity { get; set; }
		public string encryptionpsk { get; set; }
		public string historycachesize { get; set; }
		public string historyindexcachesize { get; set; }
		public string hostname { get; set; }
		public PSObject listenip { get; set; }
		public string listenport { get; set; }
		public bool proxymode { get; set; }
		public string server { get; set; }
		public string serverport { get; set; }
		public PSObject sourceip { get; set; }
		public int startdiscoverers { get; set; }
		public int starthttppollers { get; set; }
		public int startipmipollers { get; set; }
		public int startpingers { get; set; }
		public string startpollers { get; set; }
		public int startpollersunreachable { get; set; }
		public int starttrappers { get; set; }
		public int timeout { get; set; }
		#endregion Parameters

		public General () {
			cachesize = "8M";
			enabled = true;
			encryption = true;
			encryptionidentity = null;
			encryptionpsk = null;
			historycachesize = "16M";
			historyindexcachesize = "4M";
			hostname = "Zabbix proxy";
			listenip = null;
			listenport = "10051";
			proxymode = true;
			server = null;
			serverport = "10051";
			sourceip = null;
			startdiscoverers = 1;
			starthttppollers = 1;
			startipmipollers = 0;
			startpingers = 1;
			startpollers = "5";
			startpollersunreachable = 1;
			starttrappers = 5;
			timeout = 4;
		}

		public General (
			string Cachesize,
			byte Enabled,
			byte Encryption,
			string Encryptionidentity,
			string Encryptionpsk,
			string Historycachesize,
			string Historyindexcachesize,
			string Hostname,
			PSObject Listenip,
			string Listenport,
			byte Proxymode,
			string Server,
			string Serverport,
			PSObject Sourceip,
			int Startdiscoverers,
			int Starthttppollers,
			int Startipmipollers,
			int Startpingers,
			string Startpollers,
			int Startpollersunreachable,
			int Starttrappers,
			int Timeout
		) {
			cachesize = Cachesize;
			enabled = (Enabled == 0) ? false : true;
			encryption = (Encryption == 0) ? false : true;
			encryptionidentity = Encryptionidentity;
			encryptionpsk = Encryptionpsk;
			historycachesize = Historycachesize;
			historyindexcachesize = Historyindexcachesize;
			hostname = Hostname;
			listenip = Listenip;
			listenport = Listenport;
			proxymode = (Proxymode == 0) ? false : true;
			server = Server;
			serverport = Serverport;
			sourceip = Sourceip;
			startdiscoverers = Startdiscoverers;
			starthttppollers = Starthttppollers;
			startipmipollers = Startipmipollers;
			startpingers = Startpingers;
			startpollers = Startpollers;
			startpollersunreachable = Startpollersunreachable;
			starttrappers = Starttrappers;
			timeout = Timeout;
		}
	}
}
