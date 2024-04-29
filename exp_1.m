numUsers = 2;
cfgTx = wlanEHTMUConfig('CBW320','NumUsers',numUsers);
cfgTx.NumTransmitAntennas = 2;

userMCS = [4 6]; % MCS per user
for u = 1:numUsers
    cfgTx.User{u}.MCS = userMCS(u);
    cfgTx.User{u}.APEPLength = 10000;
    cfgTx.User{u}.NumSpaceTimeStreams = 1;
end

% Specify propagation channel
numRx = cfgTx.NumTransmitAntennas; % Number of receive antennas
delayProfile = 'Model-D'; % TGax channel delay profile

% Specify impairments
noisePower = -50; % Noise power to apply in dBW
cfo = 62e3; % Carrier frequency offset Hz

% Generate the waveform using a larger IFFT than required for the nominal
% baseband rate, resulting in an oversampled waveform
osf = 1; % Oversampling factor
% Generate waveform
rxWaveform = helperSigRecGenerateWaveform(cfgTx,numRx,delayProfile,noisePower,cfo,osf);