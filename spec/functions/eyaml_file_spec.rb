require 'spec_helper'

describe 'eyaml_file' do

  let :secret do
    'ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEwDQYJKoZIhvcNAQEBBQAEggEA0G2Cl2yCPlMsXkj3KOzMYO+kyXdSIoVad533Gr1FQaU7VqpM+rbt7CYM5WytFNYotsYyqxoSW3pGKKGxHL9f0c4q+xGZHV1GaHoR4rCnTps6fpyWVENkQJPZoEKi/fHSN2y+TryCf7Bt+3WRumkspZtUiZ0sG5G0kC80ssrDbbm2mSxwcZ1AvfEozcrCtCHJr3qxmFMEkHvhpW/roumuyhlgwhre6tkE7gqyntFrAR5Hzlt0Mk83Fg345qyKh/aq3iAv412/GgbKhFlHtMDcfW2y5ntZozuyvG7W73HQ64snRNR9JLUzZuhm0o/YQfUYFoSQIQIdi/TxCXb6nIZ46DA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBD5w0KZx5jxul3GUbSUXpvDgBCO/6XLdwlHb16bagi0igXf]'
  end

  let :other do
    'ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEwDQYJKoZIhvcNAQEBBQAEggEARG6qAG/UV5FpnGMXgOEqb2nuRczFLKzoSnJRwWcaRjp6Gqc5EIZICe1/PwMYOAM5/Wyb7YxqjkMO20G+p0oqzUBSz3Px5aaTJ73nFhySnm/VUO4TcgZj2cxSMqQqGV2T3ua9Wp9jIlhHsXWJamD89z6BUhjc2bqA4m3Nqzoam4a6H1sMBjund+/ScqRUPV4m7SARPmEo0TCb03ulyrWrtpo2k77nTb/CL3mZoItX6ThyUiliIZYacEoiA8uIkro4jhkFsWUsrC86DrMiSF5+NzXYUnRliLKH8rEDZRH2kcT+Cxc9fw8wpvOYt62nXiRTdqm0UbOQijAmqObMiT4zLDA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBBU2HSH2kz4dMvZAQiMtsb/gBDT7laMfjNJzat69J+ZFy2s]'
  end

  it { is_expected.not_to eq(nil) }
  it { is_expected.to run.with_params().and_raise_error(ArgumentError, /wrong number of arguments/i) }

  context 'using a file at /tmp/encrypted' do
    context 'using default keys' do
      before(:each) do
        MockFunction.new('file') { |f|
          f.stubs(:call).with(['/tmp/encrypted']).returns(secret)
        }
      end

      it { is_expected.to run.with_params('/tmp/encrypted').and_return('hello') }
    end
    context 'using alternate keys' do
      before(:each) do
        MockFunction.new('file') { |f|
          f.stubs(:call).with(['/tmp/encrypted']).returns(other)
        }
      end

      it { is_expected.to run.with_params('/tmp/encrypted', 'other').and_return('other') }
    end
  end

  context 'using a file encrypted in module' do
    before(:each) do
      MockFunction.new('file') { |f|
        f.stubs(:call).with(['foo/encrypted']).returns(secret)
      }
    end

    it { is_expected.to run.with_params('foo/encrypted').and_return('hello') }
  end

end
