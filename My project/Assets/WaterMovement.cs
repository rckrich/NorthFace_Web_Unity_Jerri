using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaterMovement : MonoBehaviour
{
    public float speed = 1.0f; // Velocidad del movimiento
    private Mesh mesh; // Malla del objeto

    private void Start()
    {
        mesh = GetComponent<MeshFilter>().mesh; // Obtener la malla del objeto
    }

    private void Update()
    {
        Vector3[] vertices = mesh.vertices; // Obtener todos los vertices de la malla

        // Mover cada vértice de la malla
        for (int i = 0; i < vertices.Length; i++)
        {
            vertices[i].y = Mathf.Sin(Time.time * speed + vertices[i].x + vertices[i].y + vertices[i].z) * 0.1f; // Mover el vértice en el eje y
        }

        mesh.vertices = vertices; // Actualizar la malla con los nuevos vertices
        mesh.RecalculateNormals(); // Recalcular las normales para suavizar la superficie
    }
}