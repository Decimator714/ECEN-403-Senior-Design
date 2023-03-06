//------------------------------------------------
// Libraries for Neural NEtwork
#include <EloquentTinyML.h>
#include <eloquent_tinyml/tensorflow.h>
#include "Fault_model.h"

//------------------------------------------------
// Instantiate variables for Neural Network
#define N_INPUTS 8
#define N_OUTPUTS 5
#define TENSOR_ARENA_SIZE 2*1024

Eloquent::TinyML::TensorFlow::TensorFlow<N_INPUTS, N_OUTPUTS, TENSOR_ARENA_SIZE> tf;

//------------------------------------------------
// Define Functions
//------------------------------------------------

void setup() {

  // Setup Serial
  Serial.begin(115200);
  delay(4000);

  // Setup DNN
  tf.begin(Fault_model);
  // check if model loaded fine
  if (!tf.isOk()) {
    Serial.print("ERROR: ");
    Serial.println(tf.getErrorMessage());   
    while (true) delay(1000);
    }

  // Setup WIFI Access Point
    
    
}

float x1, x2, x3, x4, x5, x6, x7, x8 = 0;

void loop() {

  
    // Save data to propper variables and normalize
    float input[8] = {x1, x2, x3, x4, x5, x6, x7, x8};
    float output[5] = {0};
    
    // Call DNN function and predict input
    float predicted = tf.predict(input, output);
  
    // Send Output data

 }
