using System;
using System.Management.Automation;

namespace OPNsense.HAProxy {
	public class Acl {
		#region Parameters
		public string custom_acl { get; set; }
		public string description { get; set; }
		public PSObject expression { get; set; }
		public string hdr { get; set; }
		public string hdr_beg { get; set; }
		public string hdr_end { get; set; }
		public string hdr_reg { get; set; }
		public string hdr_sub { get; set; }
		public string id { get; set; }
		public string name { get; set; }
		public uint nbsrv { get; set; }
		public PSObject nbsrv_backend { get; set; }
		public bool negate { get; set; }
		public string path { get; set; }
		public string path_beg { get; set; }
		public string path_dir { get; set; }
		public string path_end { get; set; }
		public string path_reg { get; set; }
		public string path_sub { get; set; }
		public PSObject queryBackend { get; set; }
		public string src { get; set; }
		public int src_bytes_in_rate { get; set; }
		public PSObject src_bytes_in_rate_comparison { get; set; }
		public int src_bytes_out_rate { get; set; }
		public PSObject src_bytes_out_rate_comparison { get; set; }
		public int src_conn_cnt { get; set; }
		public PSObject src_conn_cnt_comparison { get; set; }
		public int src_conn_cur { get; set; }
		public PSObject src_conn_cur_comparison { get; set; }
		public int src_conn_rate { get; set; }
		public PSObject src_conn_rate_comparison { get; set; }
		public int src_http_err_cnt { get; set; }
		public PSObject src_http_err_cnt_comparison { get; set; }
		public int src_http_err_rate { get; set; }
		public PSObject src_http_err_rate_comparison { get; set; }
		public int src_http_req_cnt { get; set; }
		public PSObject src_http_req_cnt_comparison { get; set; }
		public int src_http_req_rate { get; set; }
		public PSObject src_http_req_rate_comparison { get; set; }
		public int src_kbytes_in { get; set; }
		public PSObject src_kbytes_in_comparison { get; set; }
		public int src_kbytes_out { get; set; }
		public PSObject src_kbytes_out_comparison { get; set; }
		public int src_port { get; set; }
		public PSObject src_port_comparison { get; set; }
		public int src_sess_cnt { get; set; }
		public PSObject src_sess_cnt_comparison { get; set; }
		public int src_sess_rate { get; set; }
		public PSObject src_sess_rate_comparison { get; set; }
		public string ssl_c_ca_commonname { get; set; }
		public uint ssl_c_verify_code { get; set; }
		public string ssl_sni { get; set; }
		public string ssl_sni_beg { get; set; }
		public string ssl_sni_end { get; set; }
		public string ssl_sni_reg { get; set; }
		public string ssl_sni_sub { get; set; }
		public string urlparam { get; set; }
		public string url_param { get; set; }
		public string url_param_value { get; set; }
		public string value { get; set; }
		#endregion Parameters

		public Acl () {
			custom_acl = null;
			description = null;
			expression = null;
			hdr = null;
			hdr_beg = null;
			hdr_end = null;
			hdr_reg = null;
			hdr_sub = null;
			id = null;
			name = null;
			nbsrv = 0;
			nbsrv_backend = null;
			negate = true;
			path = null;
			path_beg = null;
			path_dir = null;
			path_end = null;
			path_reg = null;
			path_sub = null;
			queryBackend = null;
			src = null;
			src_bytes_in_rate = 0;
			src_bytes_in_rate_comparison = null;
			src_bytes_out_rate = 0;
			src_bytes_out_rate_comparison = null;
			src_conn_cnt = 0;
			src_conn_cnt_comparison = null;
			src_conn_cur = 0;
			src_conn_cur_comparison = null;
			src_conn_rate = 0;
			src_conn_rate_comparison = null;
			src_http_err_cnt = 0;
			src_http_err_cnt_comparison = null;
			src_http_err_rate = 0;
			src_http_err_rate_comparison = null;
			src_http_req_cnt = 0;
			src_http_req_cnt_comparison = null;
			src_http_req_rate = 0;
			src_http_req_rate_comparison = null;
			src_kbytes_in = 0;
			src_kbytes_in_comparison = null;
			src_kbytes_out = 0;
			src_kbytes_out_comparison = null;
			src_port = 0;
			src_port_comparison = null;
			src_sess_cnt = 0;
			src_sess_cnt_comparison = null;
			src_sess_rate = 0;
			src_sess_rate_comparison = null;
			ssl_c_ca_commonname = null;
			ssl_c_verify_code = 0;
			ssl_sni = null;
			ssl_sni_beg = null;
			ssl_sni_end = null;
			ssl_sni_reg = null;
			ssl_sni_sub = null;
			urlparam = null;
			url_param = null;
			url_param_value = null;
			value = null;
		}

		public Acl (
			string Custom_Acl,
			string Description,
			PSObject Expression,
			string Hdr,
			string Hdr_Beg,
			string Hdr_End,
			string Hdr_Reg,
			string Hdr_Sub,
			string Id,
			string Name,
			uint Nbsrv,
			PSObject Nbsrv_Backend,
			bool Negate,
			string Path,
			string Path_Beg,
			string Path_Dir,
			string Path_End,
			string Path_Reg,
			string Path_Sub,
			PSObject QueryBackend,
			string Src,
			int Src_Bytes_In_Rate,
			PSObject Src_Bytes_In_Rate_Comparison,
			int Src_Bytes_Out_Rate,
			PSObject Src_Bytes_Out_Rate_Comparison,
			int Src_Conn_Cnt,
			PSObject Src_Conn_Cnt_Comparison,
			int Src_Conn_Cur,
			PSObject Src_Conn_Cur_Comparison,
			int Src_Conn_Rate,
			PSObject Src_Conn_Rate_Comparison,
			int Src_Http_Err_Cnt,
			PSObject Src_Http_Err_Cnt_Comparison,
			int Src_Http_Err_Rate,
			PSObject Src_Http_Err_Rate_Comparison,
			int Src_Http_Req_Cnt,
			PSObject Src_Http_Req_Cnt_Comparison,
			int Src_Http_Req_Rate,
			PSObject Src_Http_Req_Rate_Comparison,
			int Src_Kbytes_In,
			PSObject Src_Kbytes_In_Comparison,
			int Src_Kbytes_Out,
			PSObject Src_Kbytes_Out_Comparison,
			int Src_Port,
			PSObject Src_Port_Comparison,
			int Src_Sess_Cnt,
			PSObject Src_Sess_Cnt_Comparison,
			int Src_Sess_Rate,
			PSObject Src_Sess_Rate_Comparison,
			string Ssl_C_Ca_Commonname,
			uint Ssl_C_Verify_Code,
			string Ssl_Sni,
			string Ssl_Sni_Beg,
			string Ssl_Sni_End,
			string Ssl_Sni_Reg,
			string Ssl_Sni_Sub,
			string Urlparam,
			string Url_Param,
			string Url_Param_Value,
			string Value
		) {
			custom_acl = Custom_Acl;
			description = Description;
			expression = Expression;
			hdr = Hdr;
			hdr_beg = Hdr_Beg;
			hdr_end = Hdr_End;
			hdr_reg = Hdr_Reg;
			hdr_sub = Hdr_Sub;
			id = Id;
			name = Name;
			nbsrv = Nbsrv;
			nbsrv_backend = Nbsrv_Backend;
			negate = Negate;
			path = Path;
			path_beg = Path_Beg;
			path_dir = Path_Dir;
			path_end = Path_End;
			path_reg = Path_Reg;
			path_sub = Path_Sub;
			queryBackend = QueryBackend;
			src = Src;
			src_bytes_in_rate = Src_Bytes_In_Rate;
			src_bytes_in_rate_comparison = Src_Bytes_In_Rate_Comparison;
			src_bytes_out_rate = Src_Bytes_Out_Rate;
			src_bytes_out_rate_comparison = Src_Bytes_Out_Rate_Comparison;
			src_conn_cnt = Src_Conn_Cnt;
			src_conn_cnt_comparison = Src_Conn_Cnt_Comparison;
			src_conn_cur = Src_Conn_Cur;
			src_conn_cur_comparison = Src_Conn_Cur_Comparison;
			src_conn_rate = Src_Conn_Rate;
			src_conn_rate_comparison = Src_Conn_Rate_Comparison;
			src_http_err_cnt = Src_Http_Err_Cnt;
			src_http_err_cnt_comparison = Src_Http_Err_Cnt_Comparison;
			src_http_err_rate = Src_Http_Err_Rate;
			src_http_err_rate_comparison = Src_Http_Err_Rate_Comparison;
			src_http_req_cnt = Src_Http_Req_Cnt;
			src_http_req_cnt_comparison = Src_Http_Req_Cnt_Comparison;
			src_http_req_rate = Src_Http_Req_Rate;
			src_http_req_rate_comparison = Src_Http_Req_Rate_Comparison;
			src_kbytes_in = Src_Kbytes_In;
			src_kbytes_in_comparison = Src_Kbytes_In_Comparison;
			src_kbytes_out = Src_Kbytes_Out;
			src_kbytes_out_comparison = Src_Kbytes_Out_Comparison;
			src_port = Src_Port;
			src_port_comparison = Src_Port_Comparison;
			src_sess_cnt = Src_Sess_Cnt;
			src_sess_cnt_comparison = Src_Sess_Cnt_Comparison;
			src_sess_rate = Src_Sess_Rate;
			src_sess_rate_comparison = Src_Sess_Rate_Comparison;
			ssl_c_ca_commonname = Ssl_C_Ca_Commonname;
			ssl_c_verify_code = Ssl_C_Verify_Code;
			ssl_sni = Ssl_Sni;
			ssl_sni_beg = Ssl_Sni_Beg;
			ssl_sni_end = Ssl_Sni_End;
			ssl_sni_reg = Ssl_Sni_Reg;
			ssl_sni_sub = Ssl_Sni_Sub;
			urlparam = Urlparam;
			url_param = Url_Param;
			url_param_value = Url_Param_Value;
			value = Value;
		}
	}
}
namespace OPNsense.HAProxy {
	public class Action {
		#region Parameters
		public string actionFind { get; set; }
		public string actionName { get; set; }
		public string actionValue { get; set; }
		public string custom { get; set; }
		public string description { get; set; }
		public string http_request_add_header_content { get; set; }
		public string http_request_add_header_name { get; set; }
		public string http_request_auth { get; set; }
		public string http_request_del_header_name { get; set; }
		public string http_request_lua { get; set; }
		public string http_request_redirect { get; set; }
		public string http_request_replace_header_name { get; set; }
		public string http_request_replace_header_regex { get; set; }
		public string http_request_replace_value_name { get; set; }
		public string http_request_replace_value_regex { get; set; }
		public string http_request_set_header_content { get; set; }
		public string http_request_set_header_name { get; set; }
		public string http_request_use_service { get; set; }
		public string http_response_add_header_content { get; set; }
		public string http_response_add_header_name { get; set; }
		public string http_response_del_header_name { get; set; }
		public string http_response_lua { get; set; }
		public string http_response_replace_header_name { get; set; }
		public string http_response_replace_header_regex { get; set; }
		public string http_response_replace_value_name { get; set; }
		public string http_response_replace_value_regex { get; set; }
		public string http_response_set_header_content { get; set; }
		public string http_response_set_header_name { get; set; }
		public uint http_response_set_status_code { get; set; }
		public string http_response_set_status_reason { get; set; }
		public PSObject linkedAcls { get; set; }
		public string name { get; set; }
		public PSObject Operator { get; set; }
		public string tcp_request_content_lua { get; set; }
		public string tcp_request_content_use_service { get; set; }
		public string tcp_response_content_lua { get; set; }
		public PSObject testType { get; set; }
		public PSObject type { get; set; }
		public PSObject useBackend { get; set; }
		public PSObject useServer { get; set; }
		public PSObject use_backend { get; set; }
		public PSObject use_server { get; set; }
		#endregion Parameters

		public Action () {
			actionFind = null;
			actionName = null;
			actionValue = null;
			custom = null;
			description = null;
			http_request_add_header_content = null;
			http_request_add_header_name = null;
			http_request_auth = null;
			http_request_del_header_name = null;
			http_request_lua = null;
			http_request_redirect = null;
			http_request_replace_header_name = null;
			http_request_replace_header_regex = null;
			http_request_replace_value_name = null;
			http_request_replace_value_regex = null;
			http_request_set_header_content = null;
			http_request_set_header_name = null;
			http_request_use_service = null;
			http_response_add_header_content = null;
			http_response_add_header_name = null;
			http_response_del_header_name = null;
			http_response_lua = null;
			http_response_replace_header_name = null;
			http_response_replace_header_regex = null;
			http_response_replace_value_name = null;
			http_response_replace_value_regex = null;
			http_response_set_header_content = null;
			http_response_set_header_name = null;
			http_response_set_status_code = 0;
			http_response_set_status_reason = null;
			linkedAcls = null;
			name = null;
			Operator = null;
			tcp_request_content_lua = null;
			tcp_request_content_use_service = null;
			tcp_response_content_lua = null;
			testType = null;
			type = null;
			useBackend = null;
			useServer = null;
			use_backend = null;
			use_server = null;
		}

		public Action (
			string ActionFind,
			string ActionName,
			string ActionValue,
			string Custom,
			string Description,
			string Http_Request_Add_Header_Content,
			string Http_Request_Add_Header_Name,
			string Http_Request_Auth,
			string Http_Request_Del_Header_Name,
			string Http_Request_Lua,
			string Http_Request_Redirect,
			string Http_Request_Replace_Header_Name,
			string Http_Request_Replace_Header_Regex,
			string Http_Request_Replace_Value_Name,
			string Http_Request_Replace_Value_Regex,
			string Http_Request_Set_Header_Content,
			string Http_Request_Set_Header_Name,
			string Http_Request_Use_Service,
			string Http_Response_Add_Header_Content,
			string Http_Response_Add_Header_Name,
			string Http_Response_Del_Header_Name,
			string Http_Response_Lua,
			string Http_Response_Replace_Header_Name,
			string Http_Response_Replace_Header_Regex,
			string Http_Response_Replace_Value_Name,
			string Http_Response_Replace_Value_Regex,
			string Http_Response_Set_Header_Content,
			string Http_Response_Set_Header_Name,
			uint Http_Response_Set_Status_Code,
			string Http_Response_Set_Status_Reason,
			PSObject LinkedAcls,
			string Name,
			PSObject Operator_,
			string Tcp_Request_Content_Lua,
			string Tcp_Request_Content_Use_Service,
			string Tcp_Response_Content_Lua,
			PSObject TestType,
			PSObject Type,
			PSObject UseBackend,
			PSObject UseServer,
			PSObject Use_Backend,
			PSObject Use_Server
		) {
			actionFind = ActionFind;
			actionName = ActionName;
			actionValue = ActionValue;
			custom = Custom;
			description = Description;
			http_request_add_header_content = Http_Request_Add_Header_Content;
			http_request_add_header_name = Http_Request_Add_Header_Name;
			http_request_auth = Http_Request_Auth;
			http_request_del_header_name = Http_Request_Del_Header_Name;
			http_request_lua = Http_Request_Lua;
			http_request_redirect = Http_Request_Redirect;
			http_request_replace_header_name = Http_Request_Replace_Header_Name;
			http_request_replace_header_regex = Http_Request_Replace_Header_Regex;
			http_request_replace_value_name = Http_Request_Replace_Value_Name;
			http_request_replace_value_regex = Http_Request_Replace_Value_Regex;
			http_request_set_header_content = Http_Request_Set_Header_Content;
			http_request_set_header_name = Http_Request_Set_Header_Name;
			http_request_use_service = Http_Request_Use_Service;
			http_response_add_header_content = Http_Response_Add_Header_Content;
			http_response_add_header_name = Http_Response_Add_Header_Name;
			http_response_del_header_name = Http_Response_Del_Header_Name;
			http_response_lua = Http_Response_Lua;
			http_response_replace_header_name = Http_Response_Replace_Header_Name;
			http_response_replace_header_regex = Http_Response_Replace_Header_Regex;
			http_response_replace_value_name = Http_Response_Replace_Value_Name;
			http_response_replace_value_regex = Http_Response_Replace_Value_Regex;
			http_response_set_header_content = Http_Response_Set_Header_Content;
			http_response_set_header_name = Http_Response_Set_Header_Name;
			http_response_set_status_code = Http_Response_Set_Status_Code;
			http_response_set_status_reason = Http_Response_Set_Status_Reason;
			linkedAcls = LinkedAcls;
			name = Name;
			Operator = Operator_;
			tcp_request_content_lua = Tcp_Request_Content_Lua;
			tcp_request_content_use_service = Tcp_Request_Content_Use_Service;
			tcp_response_content_lua = Tcp_Response_Content_Lua;
			testType = TestType;
			type = Type;
			useBackend = UseBackend;
			useServer = UseServer;
			use_backend = Use_Backend;
			use_server = Use_Server;
		}
	}
}
namespace OPNsense.HAProxy {
	public class Backend {
		#region Parameters
		public PSObject algorithm { get; set; }
		public string customOptions { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public PSObject healthCheck { get; set; }
		public bool healthCheckEnabled { get; set; }
		public bool healthCheckLogStatus { get; set; }
		public string id { get; set; }
		public PSObject linkedActions { get; set; }
		public PSObject linkedErrorfiles { get; set; }
		public PSObject linkedServers { get; set; }
		public PSObject mode { get; set; }
		public string name { get; set; }
		public PSObject proxyProtocol { get; set; }
		public string source { get; set; }
		public string stickiness_bytesInRatePeriod { get; set; }
		public string stickiness_bytesOutRatePeriod { get; set; }
		public string stickiness_connRatePeriod { get; set; }
		public uint stickiness_cookielength { get; set; }
		public string stickiness_cookiename { get; set; }
		public PSObject stickiness_dataTypes { get; set; }
		public string stickiness_expire { get; set; }
		public string stickiness_httpErrRatePeriod { get; set; }
		public string stickiness_httpReqRatePeriod { get; set; }
		public PSObject stickiness_pattern { get; set; }
		public string stickiness_sessRatePeriod { get; set; }
		public string stickiness_size { get; set; }
		public string tuning_defaultserver { get; set; }
		public bool tuning_noport { get; set; }
		public uint tuning_retries { get; set; }
		public string tuning_timeoutCheck { get; set; }
		public string tuning_timeoutConnect { get; set; }
		public string tuning_timeoutServer { get; set; }
		#endregion Parameters

		public Backend () {
			algorithm = null;
			customOptions = null;
			description = null;
			enabled = true;
			healthCheck = null;
			healthCheckEnabled = true;
			healthCheckLogStatus = true;
			id = null;
			linkedActions = null;
			linkedErrorfiles = null;
			linkedServers = null;
			mode = null;
			name = null;
			proxyProtocol = null;
			source = null;
			stickiness_bytesInRatePeriod = "1m";
			stickiness_bytesOutRatePeriod = "1m";
			stickiness_connRatePeriod = "10s";
			stickiness_cookielength = 0;
			stickiness_cookiename = null;
			stickiness_dataTypes = null;
			stickiness_expire = "30m";
			stickiness_httpErrRatePeriod = "10s";
			stickiness_httpReqRatePeriod = "10s";
			stickiness_pattern = null;
			stickiness_sessRatePeriod = "10s";
			stickiness_size = "50k";
			tuning_defaultserver = null;
			tuning_noport = true;
			tuning_retries = 0;
			tuning_timeoutCheck = null;
			tuning_timeoutConnect = null;
			tuning_timeoutServer = null;
		}

		public Backend (
			PSObject Algorithm,
			string CustomOptions,
			string Description,
			bool Enabled,
			PSObject HealthCheck,
			bool HealthCheckEnabled,
			bool HealthCheckLogStatus,
			string Id,
			PSObject LinkedActions,
			PSObject LinkedErrorfiles,
			PSObject LinkedServers,
			PSObject Mode,
			string Name,
			PSObject ProxyProtocol,
			string Source,
			string Stickiness_BytesInRatePeriod,
			string Stickiness_BytesOutRatePeriod,
			string Stickiness_ConnRatePeriod,
			uint Stickiness_Cookielength,
			string Stickiness_Cookiename,
			PSObject Stickiness_DataTypes,
			string Stickiness_Expire,
			string Stickiness_HttpErrRatePeriod,
			string Stickiness_HttpReqRatePeriod,
			PSObject Stickiness_Pattern,
			string Stickiness_SessRatePeriod,
			string Stickiness_Size,
			string Tuning_Defaultserver,
			bool Tuning_Noport,
			uint Tuning_Retries,
			string Tuning_TimeoutCheck,
			string Tuning_TimeoutConnect,
			string Tuning_TimeoutServer
		) {
			algorithm = Algorithm;
			customOptions = CustomOptions;
			description = Description;
			enabled = Enabled;
			healthCheck = HealthCheck;
			healthCheckEnabled = HealthCheckEnabled;
			healthCheckLogStatus = HealthCheckLogStatus;
			id = Id;
			linkedActions = LinkedActions;
			linkedErrorfiles = LinkedErrorfiles;
			linkedServers = LinkedServers;
			mode = Mode;
			name = Name;
			proxyProtocol = ProxyProtocol;
			source = Source;
			stickiness_bytesInRatePeriod = Stickiness_BytesInRatePeriod;
			stickiness_bytesOutRatePeriod = Stickiness_BytesOutRatePeriod;
			stickiness_connRatePeriod = Stickiness_ConnRatePeriod;
			stickiness_cookielength = Stickiness_Cookielength;
			stickiness_cookiename = Stickiness_Cookiename;
			stickiness_dataTypes = Stickiness_DataTypes;
			stickiness_expire = Stickiness_Expire;
			stickiness_httpErrRatePeriod = Stickiness_HttpErrRatePeriod;
			stickiness_httpReqRatePeriod = Stickiness_HttpReqRatePeriod;
			stickiness_pattern = Stickiness_Pattern;
			stickiness_sessRatePeriod = Stickiness_SessRatePeriod;
			stickiness_size = Stickiness_Size;
			tuning_defaultserver = Tuning_Defaultserver;
			tuning_noport = Tuning_Noport;
			tuning_retries = Tuning_Retries;
			tuning_timeoutCheck = Tuning_TimeoutCheck;
			tuning_timeoutConnect = Tuning_TimeoutConnect;
			tuning_timeoutServer = Tuning_TimeoutServer;
		}
	}
}
namespace OPNsense.HAProxy {
	public class ErrorFile {
		#region Parameters
		public PSObject code { get; set; }
		public string content { get; set; }
		public string description { get; set; }
		public string id { get; set; }
		public string name { get; set; }
		#endregion Parameters

		public ErrorFile () {
			code = null;
			content = null;
			description = null;
			id = null;
			name = null;
		}

		public ErrorFile (
			PSObject Code,
			string Content,
			string Description,
			string Id,
			string Name
		) {
			code = Code;
			content = Content;
			description = Description;
			id = Id;
			name = Name;
		}
	}
}
namespace OPNsense.HAProxy {
	public class Frontend {
		#region Parameters
		public Object bind { get; set; }
		public string bindOptions { get; set; }
		public PSObject connectionBehaviour { get; set; }
		public string customOptions { get; set; }
		public PSObject defaultBackend { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public bool forwardFor { get; set; }
		public string id { get; set; }
		public PSObject linkedActions { get; set; }
		public PSObject linkedErrorfiles { get; set; }
		public bool logging_detailedLog { get; set; }
		public bool logging_dontLogNormal { get; set; }
		public bool logging_dontLogNull { get; set; }
		public bool logging_logSeparateErrors { get; set; }
		public bool logging_socketStats { get; set; }
		public PSObject mode { get; set; }
		public string name { get; set; }
		public bool ssl_advancedEnabled { get; set; }
		public PSObject ssl_bindOptions { get; set; }
		public PSObject ssl_certificates { get; set; }
		public string ssl_cipherList { get; set; }
		public string ssl_customOptions { get; set; }
		public PSObject ssl_default_certificate { get; set; }
		public bool ssl_enabled { get; set; }
		public bool ssl_hstsEnabled { get; set; }
		public bool ssl_hstsIncludeSubDomains { get; set; }
		public uint ssl_hstsMaxAge { get; set; }
		public bool ssl_hstsPreload { get; set; }
		public string stickiness_bytesInRatePeriod { get; set; }
		public string stickiness_bytesOutRatePeriod { get; set; }
		public string stickiness_connRatePeriod { get; set; }
		public bool stickiness_counter { get; set; }
		public string stickiness_counter_key { get; set; }
		public PSObject stickiness_dataTypes { get; set; }
		public string stickiness_expire { get; set; }
		public string stickiness_httpErrRatePeriod { get; set; }
		public string stickiness_httpReqRatePeriod { get; set; }
		public uint stickiness_length { get; set; }
		public PSObject stickiness_pattern { get; set; }
		public string stickiness_sessRatePeriod { get; set; }
		public string stickiness_size { get; set; }
		public uint tuning_maxConnections { get; set; }
		public string tuning_timeoutClient { get; set; }
		public string tuning_timeoutHttpKeepAlive { get; set; }
		public string tuning_timeoutHttpReq { get; set; }
		#endregion Parameters

		public Frontend () {
			bind = null;
			bindOptions = null;
			connectionBehaviour = null;
			customOptions = null;
			defaultBackend = null;
			description = null;
			enabled = true;
			forwardFor = true;
			id = null;
			linkedActions = null;
			linkedErrorfiles = null;
			logging_detailedLog = true;
			logging_dontLogNormal = true;
			logging_dontLogNull = true;
			logging_logSeparateErrors = true;
			logging_socketStats = true;
			mode = null;
			name = null;
			ssl_advancedEnabled = true;
			ssl_bindOptions = null;
			ssl_certificates = null;
			ssl_cipherList = "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256";
			ssl_customOptions = null;
			ssl_default_certificate = null;
			ssl_enabled = true;
			ssl_hstsEnabled = true;
			ssl_hstsIncludeSubDomains = true;
			ssl_hstsMaxAge = 15768000;
			ssl_hstsPreload = true;
			stickiness_bytesInRatePeriod = "1m";
			stickiness_bytesOutRatePeriod = "1m";
			stickiness_connRatePeriod = "10s";
			stickiness_counter = true;
			stickiness_counter_key = "src";
			stickiness_dataTypes = null;
			stickiness_expire = "30m";
			stickiness_httpErrRatePeriod = "10s";
			stickiness_httpReqRatePeriod = "10s";
			stickiness_length = 0;
			stickiness_pattern = null;
			stickiness_sessRatePeriod = "10s";
			stickiness_size = "50k";
			tuning_maxConnections = 0;
			tuning_timeoutClient = null;
			tuning_timeoutHttpKeepAlive = null;
			tuning_timeoutHttpReq = null;
		}

		public Frontend (
			Object Bind,
			string BindOptions,
			PSObject ConnectionBehaviour,
			string CustomOptions,
			PSObject DefaultBackend,
			string Description,
			bool Enabled,
			bool ForwardFor,
			string Id,
			PSObject LinkedActions,
			PSObject LinkedErrorfiles,
			bool Logging_DetailedLog,
			bool Logging_DontLogNormal,
			bool Logging_DontLogNull,
			bool Logging_LogSeparateErrors,
			bool Logging_SocketStats,
			PSObject Mode,
			string Name,
			bool Ssl_AdvancedEnabled,
			PSObject Ssl_BindOptions,
			PSObject Ssl_Certificates,
			string Ssl_CipherList,
			string Ssl_CustomOptions,
			PSObject Ssl_Default_Certificate,
			bool Ssl_Enabled,
			bool Ssl_HstsEnabled,
			bool Ssl_HstsIncludeSubDomains,
			uint Ssl_HstsMaxAge,
			bool Ssl_HstsPreload,
			string Stickiness_BytesInRatePeriod,
			string Stickiness_BytesOutRatePeriod,
			string Stickiness_ConnRatePeriod,
			bool Stickiness_Counter,
			string Stickiness_Counter_Key,
			PSObject Stickiness_DataTypes,
			string Stickiness_Expire,
			string Stickiness_HttpErrRatePeriod,
			string Stickiness_HttpReqRatePeriod,
			uint Stickiness_Length,
			PSObject Stickiness_Pattern,
			string Stickiness_SessRatePeriod,
			string Stickiness_Size,
			uint Tuning_MaxConnections,
			string Tuning_TimeoutClient,
			string Tuning_TimeoutHttpKeepAlive,
			string Tuning_TimeoutHttpReq
		) {
			bind = Bind;
			bindOptions = BindOptions;
			connectionBehaviour = ConnectionBehaviour;
			customOptions = CustomOptions;
			defaultBackend = DefaultBackend;
			description = Description;
			enabled = Enabled;
			forwardFor = ForwardFor;
			id = Id;
			linkedActions = LinkedActions;
			linkedErrorfiles = LinkedErrorfiles;
			logging_detailedLog = Logging_DetailedLog;
			logging_dontLogNormal = Logging_DontLogNormal;
			logging_dontLogNull = Logging_DontLogNull;
			logging_logSeparateErrors = Logging_LogSeparateErrors;
			logging_socketStats = Logging_SocketStats;
			mode = Mode;
			name = Name;
			ssl_advancedEnabled = Ssl_AdvancedEnabled;
			ssl_bindOptions = Ssl_BindOptions;
			ssl_certificates = Ssl_Certificates;
			ssl_cipherList = Ssl_CipherList;
			ssl_customOptions = Ssl_CustomOptions;
			ssl_default_certificate = Ssl_Default_Certificate;
			ssl_enabled = Ssl_Enabled;
			ssl_hstsEnabled = Ssl_HstsEnabled;
			ssl_hstsIncludeSubDomains = Ssl_HstsIncludeSubDomains;
			ssl_hstsMaxAge = Ssl_HstsMaxAge;
			ssl_hstsPreload = Ssl_HstsPreload;
			stickiness_bytesInRatePeriod = Stickiness_BytesInRatePeriod;
			stickiness_bytesOutRatePeriod = Stickiness_BytesOutRatePeriod;
			stickiness_connRatePeriod = Stickiness_ConnRatePeriod;
			stickiness_counter = Stickiness_Counter;
			stickiness_counter_key = Stickiness_Counter_Key;
			stickiness_dataTypes = Stickiness_DataTypes;
			stickiness_expire = Stickiness_Expire;
			stickiness_httpErrRatePeriod = Stickiness_HttpErrRatePeriod;
			stickiness_httpReqRatePeriod = Stickiness_HttpReqRatePeriod;
			stickiness_length = Stickiness_Length;
			stickiness_pattern = Stickiness_Pattern;
			stickiness_sessRatePeriod = Stickiness_SessRatePeriod;
			stickiness_size = Stickiness_Size;
			tuning_maxConnections = Tuning_MaxConnections;
			tuning_timeoutClient = Tuning_TimeoutClient;
			tuning_timeoutHttpKeepAlive = Tuning_TimeoutHttpKeepAlive;
			tuning_timeoutHttpReq = Tuning_TimeoutHttpReq;
		}
	}
}
namespace OPNsense.HAProxy {
	public class Healthcheck {
		#region Parameters
		public int agentPort { get; set; }
		public uint agent_port { get; set; }
		public uint checkport { get; set; }
		public string dbUser { get; set; }
		public string description { get; set; }
		public string esmtp_domain { get; set; }
		public PSObject http_expression { get; set; }
		public bool http_expressionEnabled { get; set; }
		public string http_host { get; set; }
		public PSObject http_method { get; set; }
		public bool http_negate { get; set; }
		public string http_uri { get; set; }
		public string http_value { get; set; }
		public PSObject http_version { get; set; }
		public string interval { get; set; }
		public bool mysql_post41 { get; set; }
		public string mysql_user { get; set; }
		public string name { get; set; }
		public string pgsql_user { get; set; }
		public string smtpDomain { get; set; }
		public string smtp_domain { get; set; }
		public bool tcp_enabled { get; set; }
		public PSObject tcp_matchType { get; set; }
		public string tcp_matchValue { get; set; }
		public bool tcp_negate { get; set; }
		public string tcp_sendValue { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public Healthcheck () {
			agentPort = 0;
			agent_port = 0;
			checkport = 0;
			dbUser = null;
			description = null;
			esmtp_domain = null;
			http_expression = null;
			http_expressionEnabled = true;
			http_host = "localhost";
			http_method = null;
			http_negate = true;
			http_uri = "/";
			http_value = null;
			http_version = null;
			interval = "2s";
			mysql_post41 = true;
			mysql_user = null;
			name = null;
			pgsql_user = null;
			smtpDomain = null;
			smtp_domain = null;
			tcp_enabled = true;
			tcp_matchType = null;
			tcp_matchValue = null;
			tcp_negate = true;
			tcp_sendValue = null;
			type = null;
		}

		public Healthcheck (
			int AgentPort,
			uint Agent_Port,
			uint Checkport,
			string DbUser,
			string Description,
			string Esmtp_Domain,
			PSObject Http_Expression,
			bool Http_ExpressionEnabled,
			string Http_Host,
			PSObject Http_Method,
			bool Http_Negate,
			string Http_Uri,
			string Http_Value,
			PSObject Http_Version,
			string Interval,
			bool Mysql_Post41,
			string Mysql_User,
			string Name,
			string Pgsql_User,
			string SmtpDomain,
			string Smtp_Domain,
			bool Tcp_Enabled,
			PSObject Tcp_MatchType,
			string Tcp_MatchValue,
			bool Tcp_Negate,
			string Tcp_SendValue,
			PSObject Type
		) {
			agentPort = AgentPort;
			agent_port = Agent_Port;
			checkport = Checkport;
			dbUser = DbUser;
			description = Description;
			esmtp_domain = Esmtp_Domain;
			http_expression = Http_Expression;
			http_expressionEnabled = Http_ExpressionEnabled;
			http_host = Http_Host;
			http_method = Http_Method;
			http_negate = Http_Negate;
			http_uri = Http_Uri;
			http_value = Http_Value;
			http_version = Http_Version;
			interval = Interval;
			mysql_post41 = Mysql_Post41;
			mysql_user = Mysql_User;
			name = Name;
			pgsql_user = Pgsql_User;
			smtpDomain = SmtpDomain;
			smtp_domain = Smtp_Domain;
			tcp_enabled = Tcp_Enabled;
			tcp_matchType = Tcp_MatchType;
			tcp_matchValue = Tcp_MatchValue;
			tcp_negate = Tcp_Negate;
			tcp_sendValue = Tcp_SendValue;
			type = Type;
		}
	}
}
namespace OPNsense.HAProxy {
	public class Lua {
		#region Parameters
		public string content { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public string id { get; set; }
		public string name { get; set; }
		#endregion Parameters

		public Lua () {
			content = null;
			description = null;
			enabled = true;
			id = null;
			name = null;
		}

		public Lua (
			string Content,
			string Description,
			bool Enabled,
			string Id,
			string Name
		) {
			content = Content;
			description = Description;
			enabled = Enabled;
			id = Id;
			name = Name;
		}
	}
}
namespace OPNsense.HAProxy {
	public class Server {
		#region Parameters
		public string address { get; set; }
		public string advanced { get; set; }
		public string checkDownInterval { get; set; }
		public string checkInterval { get; set; }
		public uint checkport { get; set; }
		public string description { get; set; }
		public PSObject mode { get; set; }
		public string name { get; set; }
		public uint port { get; set; }
		public string source { get; set; }
		public bool ssl { get; set; }
		public PSObject sslCA { get; set; }
		public PSObject sslClientCertificate { get; set; }
		public PSObject sslCRL { get; set; }
		public bool sslVerify { get; set; }
		public uint weight { get; set; }
		#endregion Parameters

		public Server () {
			address = null;
			advanced = null;
			checkDownInterval = null;
			checkInterval = null;
			checkport = 0;
			description = null;
			mode = null;
			name = null;
			port = 0;
			source = null;
			ssl = true;
			sslCA = null;
			sslClientCertificate = null;
			sslCRL = null;
			sslVerify = true;
			weight = 0;
		}

		public Server (
			string Address,
			string Advanced,
			string CheckDownInterval,
			string CheckInterval,
			uint Checkport,
			string Description,
			PSObject Mode,
			string Name,
			uint Port,
			string Source,
			bool Ssl,
			PSObject SslCA,
			PSObject SslClientCertificate,
			PSObject SslCRL,
			bool SslVerify,
			uint Weight
		) {
			address = Address;
			advanced = Advanced;
			checkDownInterval = CheckDownInterval;
			checkInterval = CheckInterval;
			checkport = Checkport;
			description = Description;
			mode = Mode;
			name = Name;
			port = Port;
			source = Source;
			ssl = Ssl;
			sslCA = SslCA;
			sslClientCertificate = SslClientCertificate;
			sslCRL = SslCRL;
			sslVerify = SslVerify;
			weight = Weight;
		}
	}
}
