%�����жϺ�����
function com_int(Serial_Com)        % ��������  
  global s;                 % ȫ�ֱ�������ɾ�������ֳ�����Ȼ�������У���Ϊ����ͨ���������ݴ��봮�ڡ���ֻ��Ϊ���Ժ���Ĵ��ڵ�Ԥ����
  s = Serial_Com;      %���ݴ��ھ����s  
  set(s,'BytesAvailableFcnMode','Terminator'); %�����жϴ�����ʽ��������˿��԰ٶ��˽��⣬������ͨ��get()����ѯ�����еĿ�ѡģʽ��
  set(s,'Terminator','H');  %���ô����жϵ��ַ�Ϊ"H"������Ҳ������Ϊ��ġ�ֻҪ��Arduino�Ǳ�һ�¼���
  s.BytesAvailableFcn =@ReceiveCallback;       % �����ж���Ӧ�������󣬵������жϷ���ʱ��ִ��ReceiveCallback������ 
end 