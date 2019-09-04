using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpotLight_Property : MonoBehaviour {
    public Material Mat;
    public string PropertyName;
    public Transform Player;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	public void Update () {
		if(Player!=null)
        {
            Mat.SetVector(PropertyName, Player.position);
        }
        else
        {
            Debug.Log("Assign the player Property");
        }
	}
}
