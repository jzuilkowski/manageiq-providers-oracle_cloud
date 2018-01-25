class ManageIQ::Providers::OracleCloud::CloudManager < ManageIQ::Providers::CloudManager
  require_nested :MetricsCapture
  require_nested :MetricsCollectorWorker
  require_nested :Refresher
  require_nested :RefreshWorker
  require_nested :Vm

  alias_attribute :oracle_cloud_domain, :uid_ems

  def verify_credentials(auth_type = nil, options = {})
    require 'fog/oraclecloud'
    conf = connect(options)
  rescue => err
    _log.error("Error Class=#{err.class.name}, Message=#{err.message}, Backtrace=#{err.backtrace}")
    raise MiqException::MiqInvalidCredentialsError, _("Unexpected response returned from system: #{err.message}")
  else
    conf
  end

#  def verify_credentials(auth_type = nil, options = {})
#    begin
#      connect
#    rescue => err
#      raise MiqException::MiqInvalidCredentialsError, err.message
#    end
#    true
#  end

  def connect(options = {})
    raise MiqException::MiqHostError, _("No credentials defined") if missing_credentials?(options[:auth_type])

    username    = options[:user] || authentication_userid(options[:auth_type])
    password    = options[:pass] || authentication_password(options[:auth_type])
    self.class.raw_connect(username, password, oracle_cloud_domain, hostname)
  end


#  def connect(options = {})
#    raise MiqException::MiqHostError, "No credentials defined" if missing_credentials?(options[:auth_type])

#    auth_token = authentication_token(options[:auth_type])
#    self.class.raw_connect(project, auth_token, options, options[:proxy_uri] || http_proxy_uri)
#  end

  def self.validate_authentication_args(params)
    # return args to be used in raw_connect
    return [params[:default_userid], MiqPassword.encrypt(params[:default_password])]
  end

  def self.hostname_required?
    # TODO: ExtManagementSystem is validating this
    false
  end

  def self.raw_connect(username, password, oracle_cloud_domain, hostname)
    require 'fog/oraclecloud'

    if oracle_cloud_domain.blank?
      raise MiqException::MiqInvalidCredentialsError, _("Incorrect domain - check your domain")
    end

    Fog::Compute.new({
      provider: 'oraclecloud',
      oracle_username: username,
      oracle_password: password,
      oracle_domain: oracle_cloud_domain,
      oracle_compute_api: hostname
    })
  end

#  def self.raw_connect(*args)
#    true
#  end

    def create_discovered_region(region_name, username, password, oracle_cloud_domain, hostname, all_ems_names)

    name = region_name
    name = "#{region_name} #{username}" if all_ems_names.include?(name)
    while all_ems_names.include?(name)
      name_counter = name_counter.to_i + 1 if defined?(name_counter)
      name = "#{region_name} #{name_counter}"
    end

    new_ems = create!(
        :name            => name,
        :provider_region => region_name,
        :zone            => Zone.default_zone,
        :domain         => oracle_cloud_domain,
        :compute_api    => hostname
    )
    new_ems.update_authentication(
        :default => {
            :userid   => username,
            :password => password
        }
    )
    new_ems
  end

  def self.ems_type
    @ems_type ||= "oracle_cloud".freeze
  end

  def self.description
    @description ||= "Oracle Cloud".freeze
  end
end
