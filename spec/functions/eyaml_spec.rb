require 'spec_helper'

describe 'eyaml_string' do

  let :secret do
    'ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEwDQYJKoZIhvcNAQEBBQAEggEA0G2Cl2yCPlMsXkj3KOzMYO+kyXdSIoVad533Gr1FQaU7VqpM+rbt7CYM5WytFNYotsYyqxoSW3pGKKGxHL9f0c4q+xGZHV1GaHoR4rCnTps6fpyWVENkQJPZoEKi/fHSN2y+TryCf7Bt+3WRumkspZtUiZ0sG5G0kC80ssrDbbm2mSxwcZ1AvfEozcrCtCHJr3qxmFMEkHvhpW/roumuyhlgwhre6tkE7gqyntFrAR5Hzlt0Mk83Fg345qyKh/aq3iAv412/GgbKhFlHtMDcfW2y5ntZozuyvG7W73HQ64snRNR9JLUzZuhm0o/YQfUYFoSQIQIdi/TxCXb6nIZ46DA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBD5w0KZx5jxul3GUbSUXpvDgBCO/6XLdwlHb16bagi0igXf]'
  end

  it { is_expected.not_to eq(nil) }
  it { is_expected.to run.with_params().and_raise_error(ArgumentError, /wrong number of arguments/i) }
  it { is_expected.to run.with_params(1,2).and_raise_error(ArgumentError, /wrong number of arguments/i) }
  it { is_expected.to run.with_params(secret).and_return('hello') }
end
