#line 1 "B:/college/2nd communication/Traffic_Ligth_Controller/code/Traffic_Light_Controller.c"
#line 16 "B:/college/2nd communication/Traffic_Ligth_Controller/code/Traffic_Light_Controller.c"
char i ,led ,count ,tens ,units;
void CountDown(char num){
 for (i = num; i > 3 ; i--){

 tens = i / 10;
 units = i % 10 ;
  PORTC  = tens | ( units << 4 ) ;
 Delay_ms(1000);
 }
 if (num==3){
 for (i = num; i > 0 ; i--){
  PORTC  = 0 | ((i % 10)<<4) ;
 Delay_ms(1000);
 }
  PORTC  = 0X00 ;
 Delay_ms(1000);
 }
}
void interrupt(){
 if(INTF_bit){
  PORTC  = 0X00;
 Delay_ms(100);
 if ( ~PORTB.B1 ){

 if( PORTD.B0 ) {
  PORTD.B2 =1;  PORTD.B4 =1 ;  PORTD.B3 =0;
  PORTD.B5 =0;  PORTD.B0 =0;  PORTD.B1 =0;
 for (count = 3; count > 0 ; count--){
  PORTC  = 0 | ((count % 10)<<4) ;
 Delay_ms(1000);
 }
  PORTD.B3 =1;
  PORTD.B4 =0;
 }

 else if( PORTD.B3 ){
  PORTD.B5 =1;  PORTD.B1 =1; PORTD.B0  = 0;
  PORTD.B3 =0;  PORTD.B4 =0;  PORTD.B2 =0;
 for (count = 3; count > 0 ; count--){
  PORTC  = 0 | ((count % 10)<<4) ;
 Delay_ms(1000);
 }
  PORTD.B0 =1;
  PORTD.B1 =0;
 }
  PORTC  = 0X00 ;
 Delay_ms(100);
 while( ~PORTB.B1 ){
 if( PORTB.B0 ){
 INTF_bit = 0;
 break;
 }
 }
 }
 if( PORTB.B0 )INTF_bit = 0;
 }
}

void Automatic(){
  PORTD.B5  = 1;  PORTD.B0  = 1;
  PORTD.B4  = 0;  PORTD.B3  = 0;  PORTD.B2  = 0;  PORTD.B1  = 0;
 CountDown(15);
  PORTD.B4  = 1; PORTD.B0  = 1; PORTD.B1  = 0;
  PORTD.B5 =0;  PORTD.B3  =0;  PORTD.B2  = 0;
 CountDown(3);
  PORTD.B3  = 1;  PORTD.B2  = 1;  PORTD.B1  =0 ;
  PORTD.B0  = 0;  PORTD.B4  = 0; PORTD.B5 =0;
 CountDown(23);
  PORTD.B1  = 1;  PORTD.B4  = 0; PORTD.B5 =0;
  PORTD.B2  = 0; PORTD.B0  = 0;  PORTD.B3  =1;
 CountDown(3);
}
void main() {

 TRISB.B1 = 1 ;
 TRISB.B0= 1 ;
 INTE_bit =1;
 GIE_bit =1;
 INTEDG_bit = 0;
 NOT_RBPU_bit =0;


 TRISB.B4 = 0;
 TRISB.B5 = 0;
 TRISB.B6 = 0;
 TRISB.B7 = 0;
  PORTB.B4  = 1;
  PORTB.B5  = 1;
  PORTB.B6  = 1;
  PORTB.B7  = 1;


 TRISC = 0x00;
  PORTC  = 0X00;


 TRISD = 0x00;
  PORTD  = 0x00;

 Delay_ms(1000);

 while(1){
 Automatic();
 }
}
