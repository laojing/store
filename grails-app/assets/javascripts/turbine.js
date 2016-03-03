var camera;
var renderer;
function ResizeTurb() {
	camera.aspect = $('#threecanvas').width() / $('#threecanvas').height();
	camera.updateProjectionMatrix ();
	renderer.setSize( $('#threecanvas').width(), $('#threecanvas').height() );
}

function turbine3d( srcdir ) {
	var width = $('#threecanvas').width()/10.0;
	var height = $('#threecanvas').height()/10.0;
	var scene = new THREE.Scene();

	// create a camera, which defines where we're looking at.
	camera = new THREE.PerspectiveCamera(45, width / height, 0.1, 1000);

	// create a render and set the size
	renderer = new THREE.WebGLRenderer();
	renderer.setClearColor(new THREE.Color(0xffffff));
	renderer.setSize(width*10, height*10);

	// create ground
	var groundGeometry = new THREE.CubeGeometry(width/4,height/40,width/4);
	var groundMaterial = new THREE.MeshBasicMaterial({color: 0xcccccc});
	var ground = new THREE.Mesh(groundGeometry, groundMaterial);
	ground.castShadow = true;
	scene.add( ground );
	ground.position.x=0;
	ground.position.y=-height/2;
	ground.position.z=0;

	var north = new THREE.Mesh( new THREE.SphereGeometry(0.2,10,10),
								new THREE.MeshLambertMaterial({color: 0x007755}) );
	north.position.x=-width/10;
	north.position.y=height/80;
	ground.add(north);

	var northarrow = new THREE.ArrowHelper(
									new THREE.Vector3(0, 0, 0),
									new THREE.Vector3(0, 1, 0),
									width/8, 0x7777aa, 1, 0.5 );
	northarrow.rotation.y = Math.PI;
	northarrow.rotation.z = Math.PI/2;
	ground.add(northarrow);

	// create tower
	var geometry = new THREE.CylinderGeometry( width/100, width/50, height*2.0/3, 20 );
	var material = new THREE.MeshBasicMaterial({color: 0xbcbcbc});
	var cylinder = new THREE.Mesh( geometry, material );
	cylinder.position.y=-height/6;
	scene.add( cylinder );

	// create a nacell
	var cubeGeometry = new THREE.CubeGeometry(width/10,width/20,width/20);
	var cubeMaterial = new THREE.MeshBasicMaterial({color: 0x999999});
	var nacelle = new THREE.Mesh(cubeGeometry, cubeMaterial);
	nacelle.castShadow = true;
	nacelle.position.x=0;
	nacelle.position.y=height/6;
	nacelle.position.z=0;
	scene.add(nacelle);

	// create hub
	var sphereGeometry = new THREE.SphereGeometry(width/40,20,20);
	var sphereMaterial = new THREE.MeshBasicMaterial({color: 0x7777aa});
	var hub = new THREE.Mesh(sphereGeometry,sphereMaterial);
	hub.position.x=-width*6/80;
	hub.position.y=0;
	hub.position.z=0;
	hub.castShadow=true;
	nacelle.add(hub);

	// create blade1 axis
	var blade1axist = new THREE.Mesh( 
					new THREE.CylinderGeometry( 0.3, 0.3, 1, 3 ),
					new THREE.MeshLambertMaterial({color: 0xdddddd}) );
	blade1axist.rotation.x = Math.PI;
	hub.add( blade1axist );
	var blade1axis = new THREE.Mesh( 
					new THREE.CylinderGeometry( 0.3, 0.3, 1, 3 ),
					new THREE.MeshLambertMaterial({color: 0xdddddd}) );
	blade1axist.add( blade1axis );

	// create blade2 axis
	var blade2axist = new THREE.Mesh( 
					new THREE.CylinderGeometry( 0.3, 0.3, 0.1, 3 ),
					new THREE.MeshLambertMaterial({color: 0xdddddd}) );
	blade2axist.rotation.x = Math.PI/3
	hub.add( blade2axist );

	var blade2axis = new THREE.Mesh( 
					new THREE.CylinderGeometry( 0.3, 0.3, 0.1, 3 ),
					new THREE.MeshLambertMaterial({color: 0xdddddd}) );
	blade2axist.add( blade2axis );
	

	// create blade3 axis
	var blade3axist = new THREE.Mesh( 
					new THREE.CylinderGeometry( 0.3, 0.3, 1, 3 ),
					new THREE.MeshLambertMaterial({color: 0xdddddd}) );
	blade3axist.rotation.x = -Math.PI/3
	hub.add( blade3axist );
	var blade3axis = new THREE.Mesh( 
					new THREE.CylinderGeometry( 0.3, 0.3, 1, 3 ),
					new THREE.MeshLambertMaterial({color: 0xdddddd}) );
	blade3axist.add( blade3axis );

	var blade;
	var loader = new THREE.OBJLoader();

	loader.load ( srcdir+'/blade.obj', function(geometry) {
		var material = new THREE.MeshBasicMaterial({
			color: 0x666699
		});
		geometry.children.forEach(function(child) {
			if (child.children.length == 1) {
				if (child.children[0] instanceof THREE.Mesh) {
					child.children[0].material = material;
				}
			}
		});
		var ratio = 0.4*width/47.8;
		geometry.position.x = 35*ratio;
		geometry.scale.set ( ratio, ratio, ratio );
		blade1axis.add(geometry);
		//blade1axis.rotation.y = -0.7-Math.PI/2;

		blade2axis.add(geometry.clone());
		//blade2axis.rotation.y = -0.9-Math.PI/2; 

		blade3axis.add(geometry.clone());
		//blade3axis.rotation.y = -Math.PI/2; 
	});

	camera.position.x = -width;
	camera.position.y = height/2;
	camera.position.z = width;
	camera.lookAt(scene.position);

	var controls = new THREE.OrbitControls( camera, renderer.domElement );
	controls.target.set( 0, 0.1, 0 );
	controls.update();

	document.getElementById("threecanvas").appendChild(renderer.domElement);
	render();
	function render() {
		if ( turbstart ) {
			hub.rotation.x += 0.01;
			blade1axis.rotation.y = 0;
			blade2axis.rotation.y = 0;
			blade3axis.rotation.y = 0;
		} else {
			blade1axis.rotation.y = Math.PI/2;
			blade2axis.rotation.y = Math.PI/2;
			blade3axis.rotation.y = Math.PI/2;
		}

		northarrow.rotation.y = Math.PI - winddir;
		nacelle.rotation.y = 2*Math.PI - winddir;

		requestAnimationFrame(render);
		renderer.render(scene, camera);
	}
}
