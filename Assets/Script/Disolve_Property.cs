using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Disolve_Property : MonoBehaviour {
    public Material DisolveMaterial;
    public float speed;
    public float MaxSpeed;
    private float Currenty;
    private float StartTime;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		if(Currenty<MaxSpeed)
        {
            DisolveMaterial.SetFloat("_Disolvey", Currenty);
            Currenty += Time.deltaTime * speed;
        }
        else
        {
            StartTime = Time.time;
            Currenty = 0;
        }
        /*if(Input.GetKey(KeyCode.E))
        {
            TriggerEffect();
        }*/
	}

    private void TriggerEffect()
    {
        StartTime = Time.time;
        Currenty = 0;
    }
}
