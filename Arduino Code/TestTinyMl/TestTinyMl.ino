//------------------------------------------------
// Libraries for Neural NEtwork
#include <EloquentTinyML.h>
#include <eloquent_tinyml/tensorflow.h>
#include "Fault_model.h"


// Librbries for WIFI Access Point
// Libraries for Serial input from Simulink

//------------------------------------------------
// Instantiate variables for Neural Network
#define N_INPUTS 8
#define N_OUTPUTS 5
#define TENSOR_ARENA_SIZE 2*1024
Eloquent::TinyML::TensorFlow::TensorFlow<N_INPUTS, N_OUTPUTS, TENSOR_ARENA_SIZE> tf;


// Instantiate variables for WIFI Acess Point
// Instantiate variables for Serial Port

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
  
  // Read In data from Simulink Via Serial Comm
  if(Serial.available() > 0){
    
   // read the incoming byte
  char incomingByte = Serial.read();
  
  // check if the incoming byte is a comma separator
  if (incomingByte == ',') {
    // ignore comma separator
  } else {
    // parse the incoming byte as integer
    int value = incomingByte - '0';
  
    // check which variable to store the value in
    switch (Serial.available()) {
      case 7: x1 = value; break;
      case 6: x2 = value; break;
      case 5: x3 = value; break;
      case 4: x4 = value; break;
      case 3: x5 = value; break;
      case 2: x6 = value; break;
      case 1: x7 = value; break;
      case 0: x8 = value; break;
     }
    }
  }


  
    // Save data to propper variables and normalize
    float input[8] = {x1, x2, x3, x4, x5, x6, x7, x8};
    float output[5] = {0};
    
    // Call DNN function and predict input
    float predicted = tf.predict(input, output);
  
    // Save outputs variables
  
    // Normalize outputs for WIFI
  
    // Send outputs via WIFI

 }
