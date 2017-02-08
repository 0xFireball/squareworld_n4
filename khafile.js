let project = new Project('shapes2');
project.addAssets('Assets/**');
project.addSources('Sources');
project.addLibrary('n4');
resolve(project);
