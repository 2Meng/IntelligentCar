%�������ˣ���Ȼ����Է�װ��������û����ô����
global s;
global I;
global Route;
s = serial('COM3'); %������Arduinoռ�õ�com�ڣ��㰴���������ڼ�����豸�������п��Կ���usb-serial���Ǹ����ǡ�

set(s, 'BaudRate', 115200, 'Parity', 'none', 'DataBits',...
        8, 'StopBits', 1,'DataTerminalReady','off',...
        'RequestToSend','off');

%fopen(s); %�򿪴��ڡ�ȷ�����ڲ�Ҫ����������ռ�á�
%fclose(s);