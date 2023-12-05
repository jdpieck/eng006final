userAPIKey = '7XEAHMX5E7JA3NVM';
channelID = 2368599;
readKey = 'LLHWWTB3K780X5S1';
writeKey = 'XH18T2Q11AQPS9PA';

thingSpeakWrite(channelID, 'WriteKey', writeKey, 'Fields', 1, 'Values', 1);
output1 = thingSpeakRead(channelID, 'ReadKey', readKey, 'Fields', 1)

pause(15)

thingSpeakWrite(channelID, 'WriteKey', writeKey, 'Fields', 2, 'Values', 1);
output2 = thingSpeakRead(channelID, 'ReadKey', readKey, 'Fields', 2)
pause(15)
output3 = thingSpeakRead(channelID, 'ReadKey', readKey, 'Fields', 1)


output4 = thingSpeakRead(channelID, 'ReadKey', readKey, 'Fields', [1,2])
