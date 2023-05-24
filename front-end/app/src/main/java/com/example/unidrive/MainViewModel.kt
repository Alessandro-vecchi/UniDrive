package com.example.unidrive

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.unidrive.models.Profile
import com.example.unidrive.repository.Repository
import kotlinx.coroutines.launch

class MainViewModel(private val repository: Repository): ViewModel() {
    val myResponse: MutableLiveData<Profile> = MutableLiveData()

    fun getProfile() {
        viewModelScope.launch {
            val response: Profile = repository.getProfile()
            myResponse.value = response
        }
    }
}