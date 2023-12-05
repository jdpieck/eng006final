userAPIKey = '7XEAHMX5E7JA3NVM';
channelID = 2368599;
readKey = 'LLHWWTB3K780X5S1';
writeKey = 'XH18T2Q11AQPS9PA';

thingSpeakWrite(channelID, 'WriteKey', writeKey, 'Fields', 1, 'Values', 1);
output1 = thingSpeakRead(channelID, 'ReadKey', readKey, 'Fields', 1)

pause(1)

thingSpeakWrite(channelID, 'WriteKey', writeKey, 'Fields', 2, 'Values', 1);
output2 = thingSpeakRead(channelID, 'ReadKey', readKey, 'Fields', 2)

pause(1) %To Show that it is not pause depdent

output3 = thingSpeakRead(channelID, 'ReadKey', readKey, 'Fields', 1)

%value is perminately scrubbed
output4 = thingSpeakRead(channelID, 'ReadKey', readKey, 'Fields', [1,2])
