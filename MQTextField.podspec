Pod::Spec.new do |s|
  s.name     = 'MQTextField'
  s.version  = '1.0.0'
  s.license = 'MIT'
  s.summary  = 'A UITextField replacement with validation, tint color and more!'
  s.authors = { 'Paris Xavier Pinkney' => 'ppinkney@marqeta.com',
                'Zack Thar' => 'zthar@marqeta.com' }

  s.homepage = 'https://github.com/marqeta/mqtextfield'
  s.social_media_url = 'https://twitter.com/marqeta'

  s.description = 'MQTextField is a replacement control for UITextField that provides several useful features...'

  s.source   = { :git => 'https://github.com/marqeta/mqtextfield.git',
                 :tag => s.version.to_s }

  # Resources
  s.resource_bundle = { 'MQTextField' => 'Assets/*.{png,jpg,jpeg,gif}' }
  s.public_header_files = 'Code/*.h'

  # Platform setup
  s.platform = :ios, '7.0'
  s.requires_arc = true

  # Preserve the layout of headers in the Code directory
  s.header_mappings_dir = 'Code'

  ### Subspecs
  s.subspec 'Core' do |ss|
    ss.source_files = 'Code/*.{h,m}'
  end

end
