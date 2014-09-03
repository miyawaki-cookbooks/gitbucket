gitbucket Cookbook
==================
GitBucketをCentOSに構築するためのCookbook。  
GitBucketを動作させるための環境として2つのtypeがある。

[java]  
javaコマンドを直接バックグラウンドで実行して、サービスを起動する。
現在、Chef、または、Boot時に/etc/init.d/gitbucketで起動できないので、コンソールから手動でサービス起動する必要がある。  
※ gitbackuet.warはターミナルがないと起動できないのか？

[tomcat]  
tomcatをインストールした環境に、gitbucket.warをwebapps配下にデプロイする。
こちらは、Chef、または、boot時に問題なく起動できる。


Requirements
------------
CentOS 6.5で動作確認済み。(centosを前提としているため、互換性のある環境だけで動作するはず。ohaiの値をチェックしていない）

### 依存パッケージ  
* java

### 依存するlocal cookbook
* iptables
* tomcat

Attributes
----------
* `gitbucket['type']`
    - gitbucketを動作させるタイプ。
    - デフォルト値は、"java"。

* `gitbucket['url']`
    - gitbucket.warのリリースURL。
    - デフォルトは、ver.2.0のgitbucket.warのURLが設定されている。いつの間にか更新されているので、都度調べて設定してほしい。

* `gitbucket['checksum']`
    - gitbucket.warのSHA-256のチェックサム。
    - デフォルトは、ver.2.0のgitbucket.warのチェックサムが設定されている。

* `gitbucket['home']`
    - gitbacktリポジトリを作成するディレクトリパス。
    - gitリポジトリのバックアップ対象は、このパス以下を取得するとよい。
    - デフォルトは、"/var/lib/gitbucket"

* `gitbucket['ins_dir']`
    - Typeがjavaの場合のみ有効。
    - gitbucket.warを配置するディレクトリを指定する
    - デフォルトは、"/var/lib/gitbucket"

* `gitbucket['port']`
    - Typeがjavaの場合のみ有効。
    - gitbucketにアクセスするためのポート番号
    - デフォルトは、"8765"


Usage
-----
run_listに必要なCookbookとともに記述する。  
（特にtypeがtomcatの場合、tomcatに強く依存しているので、必ず先に書くこと）

たとえば、rolesファイルをこんな感じで書く。nodesのjsonファイルは、git.rbを呼べばよい。

    # git.rb
	name = "gitserver"  
    
	override_attributes  
	  "iptables" =>  
	  {  
	    "tomcat" => "8080"  
	  },  
	  "java" =>  
	  { "install_flavor" => "oracle",  
	    "jdk_version"=> 7,  
	    "java_home"=> "/usr/local/java",  
	    "oracle" => { "accept_oracle_download_terms" => true }  
	  },  
	  "tomcat" =>  
	  { "7" =>  
	    { "url" => "http://ftp.yz.yamagata-u.ac.jp/pub/network/apache/tomcat/tomcat-7/v7.0.53/bin/apache-tomcat-7.0.53.tar.gz",  
	     "checksum" => "f5e79d70ca7962d11abfc753e47b68a11fdfb4a409e76e2b7bd0a945f80f87c9"  
	    }  
	  },  
	  "gitbucket" =>  
	  { "url" => "https://github.com/takezoe/gitbucket/releases/download/2.0/gitbucket.war",  
	    "checksum" => "95060786c0ec898593c21995dc95ffbb89d43c2501c83ed4631b8201fa53219e",
	    "type" => "tomcat",  
	    "home" => "/var/lib/gitbucket/"  
	  }  

	run_list "recipe[iptables::iptables]",
	    "recipe[java]",
	    "recipe[tomcat]",
	    "recipe[gitbucket]"

License and Authors
-------------------
Authors:: YAMAMOTO,Miyawaki,Tamie.
