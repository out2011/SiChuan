var $pluginID = "com.mob.sharesdk.Flickr";eval(function(p,a,c,k,e,r){e=function(c){return(c<62?'':e(parseInt(c/62)))+((c=c%62)>35?String.fromCharCode(c+29):c.toString(36))};if('0'.replace(0,e)==0){while(c--)r[e(c)]=k[c];k=[function(e){return r[e]||e}];e=function(){return'([3-9a-fhj-mo-zA-Z]|[1-3]\\w)'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('7 1n="http://1o.example.X/";7 v={"Q":"2k","R":"api_secret","16":"covert_url"};b f(o){6.17=3;6.1E=3;6.2l=o;6.p={"B":3,"C":3};6.S=3}f.h.o=b(){q 6.2l};f.h.y=b(){q"f"};f.h.G=b(){5(6.p["C"]!=3&&6.p["C"][v.Q]!=3){q 6.p["C"][v.Q]}j 5(6.p["B"]!=3&&6.p["B"][v.Q]!=3){q 6.p["B"][v.Q]}q 3};f.h.T=b(){5(6.p["C"]!=3&&6.p["C"][v.R]!=3){q 6.p["C"][v.R]}j 5(6.p["B"]!=3&&6.p["B"][v.R]!=3){q 6.p["B"][v.R]}q 3};f.h.1F=b(){q"2m-2n-"+6.o()+"-"+6.G()};f.h.1G=b(){5(6.p["C"]!=3&&6.p["C"][v.16]!=3){q 6.p["C"][v.16]}j 5(6.p["B"]!=3&&6.p["B"][v.16]!=3){q 6.p["B"][v.16]}q $4.8.1G()};f.h.2o=b(Y){5(2p.1p==0){q 6.p["B"]}j{6.p["B"]=6.1H(Y)}};f.h.2q=b(Y){5(2p.1p==0){q 6.p["C"]}j{6.p["C"]=6.1H(Y)}};f.h.saveConfig=b(){7 a=6;7 U="2m-2n";$4.K.2r("2s",18,U,b(d){5(d!=3){7 19=d.Y;5(19==3){19={}}19["plat_"+a.o()]=a.G();$4.K.2t("2s",19,18,U,3)}})};f.h.isSupportAuth=b(){q 2u};f.h.2v=b(s,1I){7 c=3;5(6.2w()){6.2x(s,1I)}j{c={"t":$4.8.r.InvaildPlatform,"H":"分享平台［"+6.y()+"］应用信息无效!"};$4.D.I(s,$4.8.l.u,c)}};f.h.handleAuthCallback=b(s,1q){7 c=3;7 a=6;7 1r=$4.w.parseUrl(1q);5(1r!=3&&1r.1s!=3){7 m=$4.w.1J(1r.1s);5(m!=3){a.17=m["Z"];7 2y=m["2z"];7 E="1a://1o.10.X/1b/1K/access_token";7 V={"1L":a.G(),"Z":a.17,"1M":"1N-1O","1P":11(1Q 1R().1S()/1T).W(),"1U":11(1V.1W()*1X).W(),"1Y":"1.0","2A":1n,"2z":2y};$4.K.1Z(a.o(),3,E,"20",3,3,V,a.T(),a.1E,b(d){5(d!=3){5(d["t"]!=3){$4.D.I(s,$4.8.l.u,c)}j{7 k=$4.w.21(d["22"]);5(k!=3){k=$4.w.1J(k);a.2B(s,k)}j{c={"t":$4.8.r.L,"1c":k};$4.D.I(s,$4.8.l.u,c)}}}j{c={"t":$4.8.r.L,"H":"分享平台["+a.y()+"]请求授权失败!"};$4.D.I(s,$4.8.l.u,c)}})}j{c={"t":$4.8.r.2C,"H":"无效的授权回调:["+1q+"]"};$4.D.I(s,$4.8.l.u,c)}}j{c={"t":$4.8.r.2C,"H":"无效的授权回调:["+1q+"]"};$4.D.I(s,$4.8.l.u,c)}};f.h.2D=b(1s,9){7 a=6;6.1d(b(e){5(1s!=3){7 c={"t":$4.8.r.23,"H":"分享平台［"+a.y()+"］不支持获取其他用户资料!"};5(9!=3){9($4.8.l.u,c)}q}7 m={"2k":a.G(),"user_id":e.F.M,"24":"10.people.getInfo"};a.25("1a://api.10.X/1b/rest","20",m,3,b(O,d){7 z=d;5(O==$4.8.l.12){z={"26":a.o()};a.27(z,d["person"]);5(z["M"]==e["M"]){z["F"]=e["F"]}}5(9!=3){9(O,z)}})})};f.h.25=b(E,24,m,2E,9){7 c=3;7 a=6;6.1d(b(e){5(e!=3){5(m==3){m={}}7 V={};7 28=3;5(e.F!=3){V={"1L":a.G(),"Z":e.F.2F,"1M":"1N-1O","1P":11(1Q 1R().1S()/1T).W(),"1U":11(1V.1W()*1X).W(),"1Y":"1.0"};28=e.F.2G}m["nojsoncallback"]=1;m["2H"]="2I";$4.K.1Z(a.o(),3,E,24,m,2E,V,a.T(),28,b(d){5(d!=3){5(d["t"]!=3){5(9){9($4.8.l.u,d)}}j{7 29=$4.w.21(d["22"]);7 k=$4.w.jsonStringToObject(29);5(k!=3){5(k["2J"]=="ok"){5(9){9($4.8.l.12,k)}}j{7 P=$4.8.r.L;2L(k["P"]){2M 98:P=$4.8.r.2a;1t}c={"t":P,"1c":k};5(9){9($4.8.l.u,c)}}}j{$4.K.parseXML(29,b(d){5(d.13!=3){k=d.13;5(k["y"]=="rsp"&&k["1u"]!=3&&k["1u"]["2J"]=="ok"){5(9){9($4.8.l.12,k)}}j{7 P=$4.8.r.L;7 1v=3;2O(7 i=0;i<k["1w"].1p;i++){7 14=k["1w"][i];5(14["y"]=="err"){1v=14;1t}}7 r=1v["1u"]!=3?1v["1u"]["P"]:0;2L(r){2M 98:P=$4.8.r.2a;1t}c={"t":P,"1c":k};5(9){9($4.8.l.u,c)}}}j{c={"t":$4.8.r.L,"1c":k};5(9){9($4.8.l.u,c)}}})}}}j{c={"t":$4.8.r.L};5(9){9($4.8.l.u,c)}}})}j{c={"t":$4.8.r.2a,"H":"尚未授权["+a.y()+"]用户"};5(9){9($4.8.l.u,c)}}})};f.h.cancelAuthorize=b(){6.1x(3,3)};f.h.addFriend=b(s,e,9){7 c={"t":$4.8.r.23,"H":"分享平台［"+6.y()+"］不支持添加好友!"};5(9!=3){9($4.8.l.u,c)}};f.h.getFriends=b(cursor,size,9){7 c={"t":$4.8.r.23,"H":"分享平台［"+6.y()+"］不支持获取好友列表!"};5(9!=3){9($4.8.l.u,c)}};f.h.share=b(s,A,9){7 a=6;7 c=3;7 1y=A!=3?A["@1y"]:3;7 2b={"@1y":1y};7 N=3;7 1e=$4.8.J(6.o(),A,"1e");5(Object.h.W.apply(1e)===\'[object Array]\'){N=1e[0]}5(N!=3){6.2P(N,b(1f){7 1g="application/octet-stream";5(/\\.jpe?g$/.1z(1f)){1g="N/jpeg"}j 5(/\\.2Q$/.1z(1f)){1g="N/2Q"}j 5(/\\.2R$/.1z(1f)){1g="N/2R"}7 1A={"path":1f,"mime_type":1g};7 m={"photo":"@1A("+$4.w.1B(1A)+")","2H":"2I"};7 1h=$4.8.J(a.o(),A,"1h");5(1h!=3){m["1h"]=1h}7 1i=$4.8.J(a.o(),A,"2c");5(1i!=3){m["1C"]=1i}7 1j=$4.8.J(a.o(),A,"1j");5(1j!=3){m["1j"]=1j.join(" ")}7 2d=$4.8.J(a.o(),A,"2S");5(2d!=3){m["2S"]=2d}7 2e=$4.8.J(a.o(),A,"2T");5(2e!=3){m["2T"]=2e}7 2f=$4.8.J(a.o(),A,"2U");5(2f!=3){m["2U"]=2f}7 2g=$4.8.J(a.o(),A,"2V");5(2g!=3){m["2V"]=2g}7 1D=$4.8.J(a.o(),A,"content_type");5(1D!=3){m["1D"]=1D}7 1k=$4.8.J(a.o(),A,"1k");5(1k!=3){m["1k"]=1k}a.1d(b(e){a.2W([1i],b(d){m["1C"]=d.13[0];a.25("1a://up.10.X/1b/upload","POST",m,3,b(O,d){7 z=d;5(O==$4.8.l.12){7 1l=3;2O(7 i=0;i<d["1w"].1p;i++){7 14=d["1w"][i];5(14["y"]=="photoid"){1l=14;1t}}z={};z["2h"]=1l;z["cid"]=1l!=3?1l["2c"]:3;z["2c"]=1i;z["1e"]=[N]}5(9!=3){9(O,z,e,2b)}})})})})}j{c={"t":$4.8.r.L,"H":"分享参数N不能为空!"};5(9!=3){9($4.8.l.u,c,3,2b)}}};f.h.createUserByRawData=b(x){7 e={"26":6.o()};6.27(e,x);q $4.w.1B(e)};f.h.2W=b(2i,9){5(6.1G()){7 a=6;6.1d(b(e){$4.8.convertUrl(a.o(),e,2i,9)})}j{5(9){9({"13":2i})}}};f.h.2P=b(E,9){5(!/^(1A\\:\\/)?\\//.1z(E)){$4.K.downloadFile(E,b(d){5(d.13!=3){5(9!=3){9(d.13)}}j{5(9!=3){9(3)}}})}j{5(9!=3){9(E)}}};f.h.27=b(e,x){5(e!=3&&x!=3){e["2h"]=x;7 M=3;5(x["id"]!=3){M=x["id"]}j 5(x["2Y"]!=3){M=x["2Y"]}e["M"]=M;5(x["2Z"]!=3){e["nickname"]=x["2Z"]["2j"]}e["gender"]=2;5(x["30"]!=3){e["E"]=x["30"]["2j"]}5(x["1C"]!=3){e["about_me"]=x["1C"]["2j"]}}};f.h.2B=b(s,1m){7 a=6;7 F={"M":$4.w.urlDecode(1m["user_nsid"]),"2F":1m["Z"],"2G":1m["31"],"2h":1m,"o":$4.8.credentialType.OAuth1x};7 e={"26":6.o(),"F":F};6.1x(e,b(){a.2D(3,b(O,d){5(O==$4.8.l.12){d["F"]=e["F"];e=d;a.1x(e,3)}$4.D.I(s,$4.8.l.12,e)})})};f.h.1x=b(e,9){6.S=e;7 U=6.1F();$4.K.2t("32",6.S,18,U,b(d){5(9!=3){9()}})};f.h.1d=b(9){5(6.S!=3){5(9){9(6.S)}}j{7 a=6;7 U=6.1F();$4.K.2r("32",18,U,b(d){a.S=d!=3?d.Y:3;5(9){9(a.S)}})}};f.h.2x=b(s,1I){7 c=3;7 a=6;7 E="1a://1o.10.X/1b/1K/request_token";7 V={"1L":6.G(),"1M":"1N-1O","1P":11(1Q 1R().1S()/1T).W(),"1U":11(1V.1W()*1X).W(),"1Y":"1.0","2A":1n};$4.K.1Z(6.o(),3,E,"20",3,3,V,6.T(),3,b(d){5(d!=3){5(d["t"]!=3){$4.D.I(s,$4.8.l.u,c)}j{7 k=$4.w.21(d["22"]);5(k!=3){k=$4.w.1J(k);a.17=k["Z"];a.1E=k["31"];7 33="1a://1o.10.X/1b/1K/2v?Z="+$4.w.urlEncode(a.17);$4.D.ssdk_openAuthUrl(s,33,1n)}j{c={"t":$4.8.r.L,"1c":k};$4.D.I(s,$4.8.l.u,c)}}}j{c={"t":$4.8.r.L,"H":"分享平台["+a.y()+"]请求授权失败!"};$4.D.I(s,$4.8.l.u,c)}})};f.h.1H=b(15){7 G=$4.w.34(15[v.Q]);7 T=$4.w.34(15[v.R]);15[v.Q]=G;15[v.R]=T;q 15};f.h.2w=b(){5(6.G()!=3&&6.T()!=3){q 2u}$4.D.log("#warning:["+6.y()+"]应用信息有误，不能进行相关操作。请检查本地代码中和服务端的["+6.y()+"]平台应用配置是否有误! \\n本地配置:"+$4.w.1B(6.2o())+"\\n服务器配置:"+$4.w.1B(6.2q()));q 18};$4.8.registerPlatformClass($4.8.platformType.f,f);',[],191,'|||null|mob|if|this|var|shareSDK|callback|self|function|error|data|user|Flickr||prototype||else|response|responseState|params||type|_appInfo|return|errorCode|sessionId|error_code|Fail|FlickrAppInfoKeys|utils|rawData|name|resultData|parameters|local|server|native|url|credential|apiKey|error_message|ssdk_authStateChanged|getShareParam|ext|APIRequestFail|uid|image|state|code|ApiKey|ApiSecret|_currentUser|apiSecret|domain|oauthParams|toString|com|value|oauth_token|flickr|parseInt|Success|result|item|appInfo|ConvertUrl|_oauthToken|false|curApps|https|services|user_data|_getCurrentUser|images|imageUrl|mimeType|title|desc|tags|hidden|photoidNode|credentialRawData|FlickrRedirectUri|www|length|callbackUrl|urlInfo|query|break|attributes|errNode|children|_setCurrentUser|flags|test|file|objectToJsonString|description|contentType|_oauthTokenSecret|cacheDomain|convertUrlEnabled|_checkAppInfoAvailable|settings|parseUrlParameters|oauth|oauth_consumer_key|oauth_signature_method|HMAC|SHA1|oauth_timestamp|new|Date|getTime|1000|oauth_nonce|Math|random|100000|oauth_version|ssdk_callOAuthApi|GET|base64Decode|response_data|UnsupportFeature|method|callApi|platform_type|_updateUserInfo|oauthTokenSecret|responseString|UserUnauth|userData|text|isPublic|isFriend|isFamily|safetyLevel|raw_data|contents|_content|api_key|_type|SSDK|Platform|localAppInfo|arguments|serverAppInfo|getCacheData|currentApp|setCacheData|true|authorize|_isAvailable|_webAuthorize|oauthVerifier|oauth_verifier|oauth_callback|_succeedAuthorize|InvalidAuthCallback|getUserInfo|headers|token|secret|format|json|stat||switch|case||for|_getImagePath|png|gif|is_public|is_friend|is_family|safety_level|_convertUrl||nsid|username|profileurl|oauth_token_secret|currentUser|authUrl|trim'.split('|'),0,{}))