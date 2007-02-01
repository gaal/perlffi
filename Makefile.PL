use inc::Module::Install;

# Define metadata
name            'Superglue';
license         'MIT';
all_from        'lib/Superglue.pm';

# Specific dependencies
#requires        'File::Spec'        => '0.80';
build_requires  'Test::More'        => '0.42';
#recommends      'Your::OtherModule' => '0.01';

#no_index        'directory'         => 'demos';

#install_script  'bin/myscript';

auto_install;
WriteAll;
