require 'facter'
Facter.add("install_profile_type") do
    confine :kernel  => :linux
    setcode do
        Facter::Util::Resolution.exec("cat /tmp/was-details.txt | grep -i profileType | awk -F \"=\" '{print $2}'")
    end
end