#include <sys/param.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>

#define PORT_NUMBER (short) 2000
#define SIZE_MESSAGE 100

static void interface ( int fd_cn, char *sentArg ) ;

main ( argc, argv )
 int   argc ;
 char *argv[] ;
{
 char                serv_name [MAXHOSTNAMELEN] ;
 struct hostent     *serv_host ;
 int                 fd_cn ;
 struct sockaddr_in  sock_cn ;
 char               *sentArg ;

/*-------------------------*/
/* Look for server :       */
/*  argv[2] if it is given */
/*  localhost else         */
/*-------------------------*/
 switch ( argc )
 {
  case 3 :
   sentArg = argv[1] ;
   strcpy ( serv_name, argv[2] ) ;
   break ;
  case 2 :
   sentArg = argv[1] ;
   gethostname ( serv_name, MAXHOSTNAMELEN ) ;
   break ;
  default :
   fprintf ( stderr, "Usage : Interface Chaine_a_transmettre [ Server_Name ]\n" ) ;
   exit ( 1 ) ;
 }

 serv_host = gethostbyname ( serv_name ) ;
 if ( serv_host == NULL )
 {
  fprintf ( stderr, "Interface : unable to contact server %s.\n", serv_name ) ;
  exit ( 1 ) ;
 }

/*-------------------*/
/* Create the socket */
/*-------------------*/
 fd_cn = socket ( AF_INET, SOCK_STREAM, 0 ) ;
 if ( fd_cn < 0 )
 {
  perror ( "Client socket " ) ;
  exit ( 1 ) ;
 }

/*---------------------*/
/* Prepare the connect */
/*---------------------*/
 memset ( &sock_cn, 0, sizeof sock_cn ) ;
 memcpy ( &sock_cn.sin_addr.s_addr, serv_host->h_addr, serv_host->h_length ) ;
 sock_cn.sin_family = serv_host->h_addrtype ;
 sock_cn.sin_port   = htons ( PORT_NUMBER ) ;

 if ( connect ( fd_cn, (struct sockaddr *) &sock_cn, sizeof sock_cn ) < 0 )
 {
  perror ( "Interface connect " ) ;
  shutdown ( fd_cn, 2 ) ;
  exit ( 1 ) ;
 }

 interface ( fd_cn, sentArg ) ;
 exit ( 0 ) ;
}

#define END_STRING "\n\n"

static void interface ( int fd_cn, char *sentArg )
{
 int   argLen ;
 int   sentLen ;
 char  recvArg ;
 char  prevRecv = '\0' ;

 argLen = strlen ( sentArg ) ;
 if ( ( sentLen = send ( fd_cn, sentArg, argLen, 0 ) ) != argLen )
 {
  fprintf ( stderr, "Interface : Send failed %d instead of %d.\n", sentLen, argLen ) ;
 }

 argLen = strlen ( END_STRING ) ;
 if ( ( sentLen = send ( fd_cn, END_STRING, argLen, 0 ) ) != argLen )
 {
  fprintf ( stderr, "Interface : Send failed %d instead of %d.\n", sentLen, argLen ) ;
 }

 while ( recv( fd_cn, &recvArg, 1, 0 ) > 0 )
 {
  putchar ( recvArg ) ;
  if ( prevRecv == '\n' && recvArg =='\n' ) break ;
  prevRecv = recvArg ;
 }
 shutdown ( fd_cn, 2 ) ;
 close ( fd_cn ) ;
}
