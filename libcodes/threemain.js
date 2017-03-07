'use strict'

let makeCube = () => {
  let geometry = new THREE.CubeGeometry(30, 30, 30);
  let material = new THREE.MeshPhongMaterial({color: 0xff0000});
  let mesh = new THREE.Mesh(geometry, material);
  return mesh;
  // {Plane,Box,Cone,Cylinder,Sphere,Torus}Geometory
  // Mesh{PhongMaterial,BasicMaterial}
};
let makeLight = () => {
  let directionalLight = new THREE.DirectionalLight(0xffffff);
  directionalLight.position.set(0, 0.7, 0.7);
  return directionalLight;
};
let initRenderer = (width, height) => {
  let renderer = new THREE.WebGLRenderer();
  renderer.setSize(width, height);
  renderer.shadowMapEnebled = true;
  // renderer.setClearColorHex(0xFFFFFF, 1);
  document.body.appendChild(renderer.domElement);
  return renderer;
};

let main = () => {
  let scene = new THREE.Scene();
  let width = 300;
  let height = 300;

  let camera = new THREE.PerspectiveCamera(60, width / height, 1, 1000);
  camera.position.set(0, 0, 50);

  let renderer = initRenderer(width, height);
  let light = makeLight();
  scene.add(light);
  let axis = new THREE.AxisHelper(1000);
  scene.add(axis);
  let cube = makeCube();
  scene.add(cube);
  let controls = new THREE.OrbitControls(camera);
  let i = 0;
  let renderLoop = () => {
    cube.rotation.set(0, cube.rotation.y + 0.01, cube.rotation.z + 0.01)
    renderer.render(scene, camera);
    controls.update();
    requestAnimationFrame(renderLoop);
  };
  renderLoop();
};
window.addEventListener('DOMContentLoaded', main, false);
