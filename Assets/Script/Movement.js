#pragma strict
var MoveSpeed:float;
var TurnSpeed:float;
var JumpSpeed:float;
function Update () 
{
if(Input.GetButton("Forward"))
{
transform.Translate(Vector3(1,0,0).forward*MoveSpeed*Time.deltaTime);
}
if(Input.GetButton("Backward"))
{
transform.Translate(-Vector3(1,0,0).forward*MoveSpeed*Time.deltaTime);
}
if(Input.GetButton("Left"))
{
transform.Translate(-Vector3(1,0,0).right*TurnSpeed*Time.deltaTime);
}
if(Input.GetButton("Right"))
{
transform.Translate(Vector3(1,0,0).right*TurnSpeed*Time.deltaTime);
}
if(Input.GetButton("Jump"))
{
transform.GetComponent.<Rigidbody>().AddForce(transform.up*JumpSpeed);
}
}