%�����жϺ�����
function H_Serial_interrupt(Serial_Com)        % ��������  
  global s;                 % ȫ�ֱ�������ɾ�������ֳ�����Ȼ�������У���Ϊ����ͨ���������ݴ��봮�ڡ���ֻ��Ϊ���Ժ���Ĵ��ڵ�Ԥ����
  s = Serial_Com;      %���ݴ��ھ����s  
  set(s,'BytesAvailableFcnMode','Terminator'); %�����жϴ�����ʽ��������˿��԰ٶ��˽��⣬������ͨ��get()����ѯ�����еĿ�ѡģʽ��
  set(s,'Terminator','H');  %���ô����жϵ��ַ�Ϊ"H"������Ҳ������Ϊ��ġ�ֻҪ��Arduino�Ǳ�һ�¼���
  s.BytesAvailableFcn =@ReceiveCallback;       % �����ж���Ӧ�������󣬵������жϷ���ʱ��ִ��ReceiveCallback������ 
end 

%�ж���Ӧ������
function ReceiveCallback( obj,event)     %�����ж���Ӧ����  
   global s;
   global I;
   global Route;
   a = fscanf(s);       % �������� ����Ȼ��Ҳ���Բ����ա��Ѵ�������Ϳ����ˡ��������ֻ�ǽ̸�������ü����ִ��Arduino������ķ�����
   fwrite(s,Route(I));    %д���ڣ���Arduino����������ʱû����ֹͣ������ԼӸ�����I��if����жϡ�
   I = I+1;   % ��¼�������е��������һ��  ����Ȼ��Ҳ�������������飬��ֻ��һ����ͨ�ĺ���
end  

%�������ˣ���Ȼ����Է�װ��������û����ô����
global s;
global I;
global Route;
s=serial('COM3'); %������Arduinoռ�õ�com�ڣ��㰴���������ڼ�����豸�������п��Կ���usb-serial���Ǹ����ǡ�
fopen(s); %�򿪴��ڡ�ȷ�����ڲ�Ҫ����������ռ�á�