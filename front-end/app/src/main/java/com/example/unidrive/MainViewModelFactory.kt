package com.example.unidrive

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.example.unidrive.repository.Repository

class MainViewModelFactory(private val repository: Repository): ViewModelProvider.Factory {
    // in teoria ci v al override
    fun <T : ViewModel?> create(modelClass: Class<T>): T{
        return MainViewModel(repository) as T
    }
}