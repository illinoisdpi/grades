require "ims/lti"

module LtiProvider
  module XmlConfigurable
    extend ActiveSupport::Concern

    class_methods do
      def xml_config(lti_launch_url)
        tool_config = IMS::LTI::ToolConfig.new({
          launch_url: lti_launch_url,
          title: LtiProvider::XmlConfig.tool_title,
          description: LtiProvider::XmlConfig.tool_description
        })

        tool_config.extend IMS::LTI::Extensions::Canvas::ToolConfig
        platform = IMS::LTI::Extensions::Canvas::ToolConfig::PLATFORM

        privacy_level = LtiProvider::XmlConfig.privacy_level || "public"
        tool_config.send("canvas_privacy_#{privacy_level}!")

        if LtiProvider::XmlConfig.tool_id
          tool_config.set_ext_param(platform, :tool_id, LtiProvider::XmlConfig.tool_id)
        end

        if LtiProvider::XmlConfig.course_navigation
          tool_config.canvas_course_navigation!(LtiProvider::XmlConfig.course_navigation.symbolize_keys)
        end

        if LtiProvider::XmlConfig.account_navigation
          tool_config.canvas_account_navigation!(LtiProvider::XmlConfig.account_navigation.symbolize_keys)
        end

        if LtiProvider::XmlConfig.user_navigation
          tool_config.canvas_user_navigation!(LtiProvider::XmlConfig.user_navigation.symbolize_keys)
        end

        if LtiProvider::XmlConfig.environments
          tool_config.set_ext_param(platform, :environments, LtiProvider::XmlConfig.environments.symbolize_keys)
        end

        tool_config.to_xml(indent: 2)
      end
    end
  end
end
