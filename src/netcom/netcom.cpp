#include "netcom.h"
#include "datapacket.h"
NetComDat NetCom::initUdpTx(char host[], int port){

	int sockfd; 
	sockaddr_in addr;
	hostent *he;
	int numbytes;
	int broadcast = 1;
	
	if ((he=gethostbyname(host))==NULL){
		perror("gethostname");
		exit(1);
	}
	if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) == -1){
		perror("socket");
		exit(1);
	}
	if (setsockopt(sockfd, SOL_SOCKET, SO_BROADCAST, &broadcast, sizeof broadcast) == -1) {
	perror("setsockope (SO_BROADCAST)");
		exit(1);
	}
	
	addr.sin_family = AF_INET;
	addr.sin_port = htons(port);
	addr.sin_addr = *((struct in_addr *)he->h_addr);
        
	memset(addr.sin_zero, '\0', sizeof addr.sin_zero);
	NetComDat net;

	net.sockfd = sockfd;
	net.addr_in =  addr;
	return net;
}

NetComDat NetCom::initUdpRx(char host[], int portIn){

	std::stringstream ss;
	ss<<portIn;
	const char * port = ss.str().c_str();

	int sockfd;
        struct addrinfo hints, *servinfo, *p;
        int rv;
        struct sockaddr_storage their_addr;
        socklen_t addr_len;
        char s[INET6_ADDRSTRLEN];
	
	NetComDat net;

        memset(&hints, 0, sizeof hints);
        hints.ai_family = AF_UNSPEC; // set to AF_INET to force IPv4
        hints.ai_socktype = SOCK_DGRAM;
        hints.ai_flags = AI_CANONNAME; // use my IP

	std::cout<<"Listening to port:"<<port<<" from IP:"<<host<<std::endl;
        if ((rv = getaddrinfo(host, port, &hints, &servinfo)) != 0) {
                fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
                return net;
        }

        // loop through all the results and bind to the first we can
        for(p = servinfo; p != NULL; p = p->ai_next) {
//		std::cout<<"\t"<< p->ai_canonname<<"----"<<std::endl;
//		std::cout<<"\t"<< p->ai_addr<<"----"<<std::endl;
                if ((sockfd = socket(p->ai_family, p->ai_socktype,
                                p->ai_protocol)) == -1) {
                        perror("listener: socket");
                        continue;
                }

                if (bind(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
                        close(sockfd);
                        perror("listener: bind");
                        continue;
                }

                break;
        }
	
        if (p == NULL) {
                fprintf(stderr, "listener: failed to bind socket\n");
                return net;
        }

        freeaddrinfo(servinfo);

	net.sockfd = sockfd;
	net.their_addr =  their_addr;
	
	return net;
}

int NetCom::txTs(NetComDat net, timestamp_t count, int nTx){
	std::cout<<"NetCom::txTs "<<count<<std::endl;

	char* buff = new char[6];
	*buff = typeToChar(NETCOM_UDP_TIME);

	tsToBuff(&count, buff, 6);

	std::cout<<"Buffer Out:";
	printBuff(buff,6);

	for (int i=0; i<nTx; i++)
		sendto(net.sockfd, buff, 6, 0, (struct sockaddr *)&net.addr_in, sizeof net.addr_in);
	delete buff;
}

timestamp_t NetCom::rxTs(NetComDat net){

	char s[INET6_ADDRSTRLEN];
        char buff[6] = {'\0'};;

        int numbytes;
	sockaddr_storage their_addr = net.their_addr;
        socklen_t addr_len = sizeof (their_addr);

	sockaddr_in sa = *(struct sockaddr_in *)&their_addr;

	if ((numbytes = recvfrom(net.sockfd, &buff, 20 , 0,
                (struct sockaddr *)&their_addr, &addr_len)) == -1) {
                perror("recvfrom");
                exit(1);
        }

	std::cout<<"Buffer  In:";
	printBuff(buff, 6);
	std::cout<<"Buffer Type:"<<charToType(*buff)<<std::endl;
	/// Below this line is undeeded

        printf("listener: got packet from %s\n", 
		inet_ntop(their_addr.ss_family,get_in_addr((struct sockaddr *)&their_addr), s, 
		sizeof s));

	timestamp_t ts = buffToTs(buff, 6);
	std::cout<<"Recovered Timestamp:"<<ts<<std::endl;
//        printf("listener: packet is %d bytes long\n", numbytes);
//        buff[10] = '\0';
//        printf("listener: packet contains \"%s\"\n", buff);

        return 0;
}

void *get_in_addr(struct sockaddr *sa){
        if (sa->sa_family == AF_INET) {
                return &(((struct sockaddr_in*)sa)->sin_addr);
        }

        return &(((struct sockaddr_in6*)sa)->sin6_addr);
}


